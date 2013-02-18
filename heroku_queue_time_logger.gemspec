# -*- encoding: utf-8 -*-
require File.expand_path('../lib/heroku_queue_time_logger/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Roberts, Marc"]
  gem.email         = ["marc@neutroncreations.com"]
  gem.description   = %q{heroku queue time logger}
  gem.summary       = %q{heroku queue time logger}
  gem.homepage      = "http://github.com/neutroncreations/heroku_queue_time_logger"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/.*_spec.rb})
  gem.name          = "heroku_queue_time_logger"
  gem.require_paths = ["lib"]
  gem.version       = HerokuQueueTimeLogger::VERSION
end
