# -*- encoding: utf-8 -*-
require File.expand_path('../lib/impas-client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["hideack"]
  gem.email         = ["hide.terai@gmail.com"]
  gem.description   = "Impas API client (Impas is social parameters crawling application.)"
  gem.summary       = "Impas API client"
  gem.homepage      = "http://github.com/hideack/impas-client"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "impas-client"
  gem.require_paths = ["lib"]
  gem.version       = Impas::Client::VERSION

  gem.add_dependency "faraday", "~>0.8.4"
end
