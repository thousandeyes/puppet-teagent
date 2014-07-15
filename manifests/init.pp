# == Class: teagent
#
# Puppet module for the ThousandEyes agent.
#
# === Parameters
#
# [*browserbot*]
#   Set to 'true' to enable BrowserBot.
#   Default: false
#
# [*agent_utils*]
#   Set to 'true' to install the ThousandEyes Agent Utilities.
#   Default: false
#
# [*international_langs*]
#   Set to 'true' to install the international language support package.
#   Default: false
#
# [*account_token*]
#   Account token for the agent.
#   Default is the sample value, which equals a disabled agent.
#
# [*log_path*]
#   Agent log path. Default: /var/log
#
# [*proxy_host*]
#   Proxy hostname. Default (disabled): ''
#
# [*proxy_port*]
#   Proxy port. Default (disabled): 0
#
# [*proxy_user*]
#   Proxy username. Default (disabled): ''
#
# [*proxy_pass*]
#   Proxy password. Default (disabled): ''
#
# [*ip_version*]
#   Ip version for the agent to run with. Can be either 'ipv4' or 'ipv6'.
#   Default: 'ipv4'
#
# [*set_repo*]
#   If set to false doesn't try to check depdendencies and install the repo.
#   Default: true
#
# === Examples
#
# Call teagent as a parameterized class
#
# See README for details.
#
# === Authors
#
# Paulo Cabido <paulo@thousandeyes.com>
#
# === Copyright
#
# Copyright © 2013 ThousandEyes, Inc.
#
class teagent(
  $browserbot = 'UNSET',
  $agent_utils = 'UNSET',
  $international_langs = 'UNSET',
  $account_token = 'UNSET',
  $log_path = 'UNSET',
  $proxy_host = 'UNSET',
  $proxy_port = 'UNSET',
  $proxy_user = 'UNSET',
  $proxy_pass = 'UNSET',
  $ip_version = 'UNSET',
  $set_repo = 'UNSET',
) {

  #we want the module to be fully compatible with all Puppet 2.6.x versions
  include teagent::params

  $real_browserbot = $browserbot ? {
    'UNSET' => $::teagent::params::browserbot,
    default => $browserbot,
  }

  $real_agent_utils = $agent_utils ? {
    'UNSET' => $::teagent::params::agent_utils,
    default => $agent_utils,
  }

  $real_international_langs = $international_langs ? {
    'UNSET' => $::teagent::params::international_langs,
    default => $international_langs,
  }

  $real_account_token = $account_token ? {
    'UNSET' => $::teagent::params::account_token,
    default => $account_token,
  }

  $real_log_path = $log_path ? {
    'UNSET' => $::teagent::params::log_path,
    default => $log_path,
  }

  $real_proxy_host = $proxy_host ? {
    'UNSET' => $::teagent::params::proxy_host,
    default => $proxy_host,
  }

  $real_proxy_port = $proxy_port ? {
    'UNSET' => $::teagent::params::proxy_port,
    default => $proxy_port,
  }

  $real_proxy_user = $proxy_user ? {
    'UNSET' => $::teagent::params::proxy_user,
    default => $proxy_user,
  }

  $real_proxy_pass = $proxy_pass ? {
    'UNSET' => $::teagent::params::proxy_pass,
    default => $proxy_pass,
  }

  $real_ip_version = $ip_version ? {
    'UNSET' => $::teagent::params::ip_version,
    default => $ip_version,
  }

  $real_set_repo = $set_repo ? {
    'UNSET' => $::teagent::params::set_repo,
    default => $set_repo,
  }

  # this takes care of the dependencies (repos) if set to true
  if ($real_set_repo) {
    include teagent::dependency
    $teagent_requires = [
      Class['teagent::dependency'],
      Class['teagent::repository'],
    ]
  }
  else {
    $teagent_requires = []
  }

  package { 'te-agent':
    ensure  => 'installed',
    require => $teagent_requires,
  }

  if $real_browserbot {
    package { 'te-browserbot':
      ensure  => 'installed',
      require => Package['te-agent'],
    }
  }

  if $real_agent_utils {
    package { 'te-agent-utils':
      ensure  => 'latest',
      require => Package['te-agent'],
    }
  }

  if $real_international_langs {
    package { 'te-intl-fonts':
      ensure  => 'latest',
      require => [
        Class['teagent::dependency'],
        Class['teagent::repository'],
      ],
    }
  }

  file { '/var/lib/te-agent/config_teagent.sh':
    ensure  => 'present',
    content => template('teagent/config_teagent.sh.erb'),
    mode    => '0755',
    require => [ Package['te-agent'], ],
  }

  exec { '/var/lib/te-agent/config_teagent.sh':
    subscribe   => File['/var/lib/te-agent/config_teagent.sh'],
    refreshonly => true,
  }

  # te-agent service
  include teagent::service
}
