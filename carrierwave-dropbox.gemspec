# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave/dropbox/version'

Gem::Specification.new do |spec|
  spec.name          = "carrierwave-dropbox"
  spec.version       = CarrierWave::Dropbox::VERSION
  spec.authors       = ["Robin Dupret"]
  spec.email         = ["robin.dupret@gmail.com"]
  spec.description   = %q{CarrierWave storage for Dropbox}
  spec.summary       = %q{Dropbox integration for CarrierWave}
  spec.homepage      = "https://github.com/robin850/carrierwave-dropbox"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "carrierwave", "~> 0.10"
  spec.add_dependency "dropbox-sdk", "~> 1.6.4"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.4"
  spec.add_development_dependency "rack-test", "~> 0.6"
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "sinatra", "~> 1.4"
  spec.add_development_dependency "activerecord", "~> 4.2"
end
