require File.expand_path('../lib/instancevalue/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.description   = %q{Constant values for each instance.}
  gem.summary       = %q{Constant values for each instance.}
  gem.homepage      = 'http://kachick.github.com/instancevalue'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features|declare)/})
  gem.name          = 'instancevalue'
  gem.require_paths = ['lib']
  # dup for https://github.com/rubygems/rubygems/commit/48f1d869510dcd325d6566df7d0147a086905380#-P0
  gem.version       = InstanceValue::VERSION.dup

  gem.required_ruby_version = '>=1.9.2'

  gem.add_development_dependency 'yard', '>= 0.8.5.2', '< 2'
  gem.add_development_dependency 'rake', '>= 10', '< 20'
  gem.add_development_dependency 'bundler', '>= 1.3.0', '< 2'
end