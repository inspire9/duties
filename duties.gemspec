# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = 'duties'
  spec.version       = '0.0.1'
  spec.authors       = ['Pat Allan']
  spec.email         = ['pat@freelancing-gods.com']
  spec.summary       = %q{Run activities related to a duty in a specific order}
  spec.description   = %q{A Rails engine that runs activities related to a duty in a specific order, via Sidekiq.}
  spec.homepage      = 'https://github.com/inspire9/duties'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'json'
  spec.add_runtime_dependency 'rails',   '~> 4.0'
  spec.add_runtime_dependency 'sidekiq', '> 2.17.0'

  spec.add_development_dependency 'combustion',  '0.5.1'
  spec.add_development_dependency 'rspec-rails', '~> 3.0.2'
  spec.add_development_dependency 'sqlite3',     '~> 1.3.8'
end
