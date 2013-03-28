# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'psych_analyzer/version'

Gem::Specification.new do |gem|
  gem.name          = "psych_analyzer"
  gem.version       = PsychAnalyzer::VERSION
  gem.authors       = ["Ramy Khater"]
  gem.email         = ["eng.ramymohie@gmail.com"]
  gem.description   = %q{creates a psychological profile of given content based-on provided dictionary.}
  gem.summary       = %q{creates a psychological profile of given content based-on provided dictionary.}
  gem.homepage      = "https://github.com/rayasocialmedia/psych_analyzer"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
