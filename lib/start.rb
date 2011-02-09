include GitP4Sync

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: git-p4-sync [options]"

  # opts.on("-b", "--branch [STRING]", String, "Git branch") do |o|
  #   options[:branch] = o || "master"
  # end

  opts.on("-g", "--git [STRING]", String, "Path to Git repository") do |o|
    options[:git] = o
  end
 
  opts.on("-p", "--p4 [STRING]", String, "Path to Perforce workspace directory") do |o|
    options[:p4] = o
  end

  opts.on("-P", "--pull", "Pull Git repository before processing") do |o|
    options[:pull] = o
  end

  opts.on("-S", "--submit", "Submit to Perforce after processing") do |o|
    options[:submit] = o
  end
  
  opts.on("-t", "--test", "Simulates a syncronisation without executing any command") do |o|
    options[:simulate] = o
  end
  
  opts.on("-i", "--ignore", "Items to ignore. this is a comma delimited list") do |o|
    options[:ignore] = o
  end
  
end.parse!

def error(msg)
  puts msg
  exit 1
end

error("Option --git required.") unless options[:git]
error("Option --p4 required.")  unless options[:p4]

run options

