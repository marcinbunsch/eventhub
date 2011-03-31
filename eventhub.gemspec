# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "eventhub/version"

Gem::Specification.new do |s|
  s.name        = "eventhub"
  s.version     = EventHub::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Marcin Bunsch"]
  s.email       = ["marcin@futuresimple.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby client for an unexisting GitHub Event API}
  s.description = %q{Ruby client for an unexisting GitHub Event API}

  s.rubyforge_project = "eventhub"

  s.add_dependency 'mechanize'
  s.add_dependency 'hpricot'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
