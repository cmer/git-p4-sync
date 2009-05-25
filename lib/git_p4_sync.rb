module GitP4Sync
  
  def run(options)
    # branch    = options[:branch] || "master"
    branch = "master"
    git_path  = options[:git]
    p4_path   = options[:p4]
    simulate  = options[:simulate] || false
    pull      = options[:pull] || false
    submit    = options[:submit] || false
    ignore_list =  ( options[:ignore] ? options[:ignore].split(",") : [".git"] )

    git_path = add_slash(File.expand_path(git_path))
    p4_path = add_slash(File.expand_path(p4_path))
    
    verify_path_exist!(git_path)
    verify_path_exist!(p4_path)
    
    if pull
      Dir.chdir(git_path) do
        puts "Pulling Git from remote server."
        run_cmd "git pull", simulate
      end
    end

    diff = diff_dirs(p4_path, git_path)
    
    if diff.size > 0
      diff.each do |d|
        action = d[0]
        file = strip_leading_slash(d[1])

        # todo: skip ignored files/directories
        
        puts "#{action.to_s.upcase} in Git: #{file}"
        
        Dir.chdir(p4_path) do
          case action
          when :new
            run_cmd "cp -r #{git_path}#{file} #{p4_path}#{file}", simulate
            run_cmd "#{p4_add_recursively("#{p4_path}#{file}")}", simulate
          when :deleted
            run_cmd "p4 delete #{p4_path}#{file}", simulate
          when :modified
            run_cmd "p4 edit #{p4_path}#{file}", simulate
            run_cmd "cp #{git_path}#{file} #{p4_path}#{file}", simulate
          else
            puts "Unknown change type #{action}. Stopping."
            exit 1
          end
        end
      end
      
      if submit
        git_head_commit = ""
        Dir.chdir(git_path) do
          git_head_commit = `git show --pretty=oneline`.split("\n")[0]
        end
        
        Dir.chdir(p4_path) do
          puts "Submitting changes to Perforce"
          run_cmd "p4 submit -d '#{git_head_commit.gsub("'", "''")}'", simulate
        end
      end
    else
      puts "Directories are identical. Nothing to do."
      exit 0
    end
  end
  
  def run_cmd(cmd, simulate = false, puts_prefix = "  ")
    if simulate
      puts "#{puts_prefix}simulation: #{cmd}"
    else
      puts "#{puts_prefix}#{cmd}"
    end
    
    output = ""
    output = `#{cmd}` unless simulate
    [output, $?]
  end
  
  def add_slash(path)
    path += "/" unless path[-1..-1] == "/"
    path
  end
  
  def strip_leading_slash(path)
    path.sub(/^\//, "")
  end
  
  def p4_add_recursively(path)
    "find #{path} -type f -print | p4 -x - add -f"
  end

  def verify_path_exist!(path)
    if !File.exist?(path) || !File.directory?(path)
      puts "#{path} must exist and be a directory."
      exit 1
    end
  end
end

