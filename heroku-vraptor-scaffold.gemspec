# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vraptor-scaffold/version"

Gem::Specification.new do |s|
  s.name        = "heroku-vraptor-scaffold"
  s.version     = VraptorScaffold::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Filipe Esperandio", "Rodolfo Liviero"]
  s.email       = "filipesperandio@gmail.com"
  s.homepage    = "http://github.com/filipesperandio/vraptor-scaffold"
  s.summary     = "Heroku Ready VRaptor Scaffold + Angular + Bootstrap"
  s.description = "Extending VRaptor's default scaffold to make it easier configuring new projects for heroku deployment using Angular+Bootstrap in the fron end" 
  s.post_install_message = "Thank you for installing vraptor-scaffold. Please read http://github.com/caelum/vraptor-scaffold/blob/master/README.textile for more information."
  
  s.add_dependency('thor', '0.14.6')
  s.add_dependency('activesupport', "3.0.1")
  s.add_dependency('rake', '0.9.2')

  s.add_development_dependency('rspec', '1.3.2')
  s.add_development_dependency('ZenTest', '4.4.0')
  s.add_development_dependency('simplecov', '0.5.4')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
