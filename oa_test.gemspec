# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "oa_test/version"

Gem::Specification.new do |s|
  s.add_development_dependency "oauth", ["~> 0.4.1"]
  s.add_development_dependency "httparty", ["~> 0.6.1"]
  
  s.name        = "oa_test"
  s.version     = Capykit::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Watchmen"]
  s.email       = ["watchmencore@yahoo.com"]
  s.homepage    = "http://www.github.com/watchmen"
  s.summary     = %q{OAuth mini test}
  s.description = %q{OAuth mini test for yahoo property}

  s.required_rubygems_version = ">= 1.3.7"
  s.rubyforge_project = "oa_test"

  s.files = Dir.glob("**/*.rb").delete_if { |item| item.include?(".git") }

  #s.files         = `git ls-files`.split("\n")
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  #s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.bindir        = 'bin'
  s.executables = ["oa_test"]
  s.default_executable = %q{oa_test}
end
