# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redson/version'

Gem::Specification.new do |spec|
  spec.name          = "redson"
  spec.version       = Redson::VERSION
  spec.authors       = ["Sidu Ponnappa"]
  spec.email         = ["ckponnappa@gmail.com"]
  spec.summary       = %q{Redson is a browser based MVC component framework written in Ruby using the Opal ruby-to-js compiler.}
  spec.description   = %q{Redson is a browser based MVC component framework written in Ruby using the Opal ruby-to-js compiler.}
  spec.homepage      = "http://github.com/kaiwren/redson"
  spec.license       = "MIT"

  spec.files         = `git ls-files lib/ opal/ -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "opal-jquery"
  spec.add_runtime_dependency "opal-rails"

  spec.add_development_dependency "rails", "~> 4.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-livereload"
  spec.add_development_dependency "guard-rake"
end
