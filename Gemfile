source 'https://rubygems.org'

group :development, :test do
  gem 'rake'
  gem 'nokogiri'
  gem 'puppetlabs_spec_helper', :require => false
  gem 'rspec-system-puppet', '~>2.0'
  gem 'puppet-lint', '~> 1.1.0'
  gem 'serverspec'
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end
