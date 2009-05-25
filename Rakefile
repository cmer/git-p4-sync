require 'rake'
require 'rake/testtask'
 
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end
 
task :default => :test

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "git-p4-sync"
    gemspec.summary = "Submit changes made to a Git repository into to Perforce"
    gemspec.email = "carl@carlmercier.com"
    gemspec.homepage = "http://github.com/cmer/git-p4-sync"
    gemspec.description = "Submit changes made to a Git repository into to Perforce"
    gemspec.authors = ["Carl Mercier"]
    gemspec.files =  FileList["[A-Z]*", "{bin,generators,lib,test}/**/*"]
    gemspec.rubyforge_project = 'git-p4-sync'
    gemspec.add_dependency('diff_dirs', '>= 0.1.2')
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

begin
  require 'rake/contrib/sshpublisher'
  namespace :rubyforge do

    desc "Release gem and RDoc documentation to RubyForge"
    task :release => ["rubyforge:release:gem", "rubyforge:release:docs"]

    namespace :release do
      desc "Publish RDoc to RubyForge."
      task :docs => [:rdoc] do
        config = YAML.load(
            File.read(File.expand_path('~/.rubyforge/user-config.yml'))
        )

        host = "#{config['username']}@rubyforge.org"
        remote_dir = "/var/www/cmercier/git-p4-sync/"
        local_dir = 'rdoc'

        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
      end
    end
  end
rescue LoadError
  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
end