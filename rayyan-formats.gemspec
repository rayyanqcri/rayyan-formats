# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rayyan-formats/version'

Gem::Specification.new do |spec|
  spec.name          = "rayyan-formats"
  spec.version       = RayyanFormats::CLI_VERSION
  spec.authors       = ["Hossam Hammady"]
  spec.email         = ["github@hammady.net"]
  spec.description   = %q{Rayyan formats main gem with a command line converter}
  spec.summary       = %q{Rayyan formats main gem. It offers a command line converter and delegates all the work to the rayyan-formats-core and rayyan-formats-plugins gems.}
  spec.homepage      = "https://github.com/rayyanqcri/rayyan-formats"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.executables   = ["rayyan-formats-convert"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency 'rake', '~> 13'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'coderay', '~> 1.1'
  spec.add_development_dependency 'coveralls', '~> 0.8'

  spec.add_dependency 'rayyan-formats-core', "~> 0.2.1"
  spec.add_dependency 'rayyan-formats-plugins', "~> 0.1.6"
  spec.add_dependency 'rayyan-scrapers', "~> 0.1.0"
end
