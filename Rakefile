require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'
require 'rspec-system/rake_task'
require 'puppet-lint/tasks/puppet-lint'

Bundler.require :default

PuppetLint.configuration.log_format = "%{path}:\t%{linenumber}: %{check} (%{KIND}): %{message}"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end

PuppetLint::RakeTask.new(:lint) do |config|
  config.with_context = true
  config.with_filename = true
  config.disable_checks = ['documentation', '80chars', 'class_inherits_from_params_class', 'parameter_order', '2sp_soft_tabs', 'ensure_first_param', 'arrow_alignment', 'unquoted_node_name', 'variables_not_enclosed', 'only_variable_string', 'puppet_url_without_modules']
end

task :default => [:spec]
