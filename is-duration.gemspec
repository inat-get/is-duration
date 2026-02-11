# frozen_string_literal: true

require_relative 'lib/is-duration/info'

Gem::Specification::new do |spec|
  spec.name     =   IS::Duration::Info::NAME
  spec.version  =   IS::Duration::Info::VERSION
  spec.summary  =   IS::Duration::Info::SUMMARY
  spec.authors  = [ IS::Duration::Info::AUTHOR ]
  spec.license  =   IS::Duration::Info::LICENSE
  spec.homepage =   IS::Duration::Info::HOMEPAGE

  spec.files = Dir[ 'lib/**/*.rb', 'README.md', 'LICENSE', 'coverage-badge.svg' ]

  spec.required_ruby_version = '>= 3.4'

  spec.add_dependency 'is-enum', '~> 0.8.8'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'redcarpet'
  spec.add_development_dependency 'rdoc'
end
