# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_pagseguro'
  s.version     = '2.1.3'
  s.summary     = 'Add support for Pagseguro checkout as a payment method.'
  s.description = s.summary
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'João Netto'
  s.email     = 'hi@joaonetto.me'
  s.homepage  = 'http://joaonetto.me'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.1.3'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
end
