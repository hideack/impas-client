# -*- encoding: utf-8 -*-
require File.expand_path('../lib/impas-client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["hideack"]
  gem.email         = ["hide.terai@gmail.com"]
  gem.description   = "impas client"
  gem.summary       = "impas client"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "impas-client"
  gem.require_paths = ["lib"]
  gem.version       = Impas::Client::VERSION
end
