# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{git-p4-sync}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Carl Mercier"]
  s.date = %q{2012-06-18}
  s.default_executable = %q{git-p4-sync}
  s.description = %q{Submit changes made to a Git repository into to Perforce}
  s.email = %q{carl@carlmercier.com}
  s.executables = ["git-p4-sync"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "bin/git-p4-sync",
     "lib/git_p4_sync.rb",
     "lib/init.rb",
     "lib/start.rb",
     "test/git_p4_sync_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/cmer/git-p4-sync}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{git-p4-sync}
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Submit changes made to a Git repository into to Perforce}
  s.test_files = [
    "test/git_p4_sync_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<diff_dirs>, [">= 0.1.2"])
    else
      s.add_dependency(%q<diff_dirs>, [">= 0.1.2"])
    end
  else
    s.add_dependency(%q<diff_dirs>, [">= 0.1.2"])
  end
end

#
