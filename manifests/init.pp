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
# [*$international_langs*]
#   Set to 'true' to install the international language support package.
#   Default: false
#
# [*account_token*]
#   Account token for the agent.
#   Default is the sample value, which equals a disabled agent.
#
# [*log_file*]
#   Agent log file path. Default: /var/log/te-agent.log
#
# [*proxy_host*]
#   Proxy hostname. Default (disabled): ''
#
# [*proxy_port*]
#   Proxy port. Default (disabled): 0
#
# [*ip_version*]
#   Ip version for the agent to run with. Can be either 'ipv4' or 'ipv6'.
#   Default: 'ipv4'
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
  $international_langs = 'UNSET',
  $account_token = 'UNSET',
  $log_file = 'UNSET',
  $proxy_host = 'UNSET',
  $proxy_port = 'UNSET',
  $ip_version = 'UNSET'
) {

  #we want the module to be fully compatible with all Puppet 2.6.x versions
  include teagent::params

  $real_browserbot = $browserbot ? {
    'UNSET' => $::teagent::params::browserbot,
    default => $browserbot,
  }

  $real_international_langs = $international_langs ? {
    'UNSET' => $::teagent::params::international_langs,
    default => $international_langs,
  }

  $real_account_token = $account_token ? {
    'UNSET' => $::teagent::params::account_token,
    default => $account_token,
  }

  $real_log_file = $log_file ? {
    'UNSET' => $::teagent::params::log_file,
    default => $log_file,
  }

  $real_proxy_host = $proxy_host ? {
    'UNSET' => $::teagent::params::proxy_host,
    default => $proxy_host,
  }

  $real_proxy_port = $proxy_port ? {
    'UNSET' => $::teagent::params::proxy_port,
    default => $proxy_port,
  }

  $real_ip_version = $ip_version ? {
    'UNSET' => $::teagent::params::ip_version,
    default => $ip_version,
  }

  # this takes care of the dependencies (repos)
  include teagent::dependency

  package { 'te-agent':
    ensure  => 'installed',
    require => [
      Class['teagent::dependency'],
      Class['teagent::repository'],
    ],
  }

  if $browserbot {
    package { 'te-browserbot':
      ensure  => 'installed',
      require => Package['te-agent'],
    }
  }

  if $international_langs {
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
