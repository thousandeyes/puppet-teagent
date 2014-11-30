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
class teagent (
  $account_token       = 'your_enterprise_token_here',
  $agent_utils         = false,
  $bind_addr           = $::ipaddress,
  $browserbot          = false,
  $controller          = 'sc1.thousandeyes.com',
  $group               = 'root',
  $international_langs = false,
  $log_file_size       = 10,
  $log_level           = 'DEBUG',
  $log_path            = '/var/log',
  $num_log_files       = 13,
  $proxy_bypass        = undef,
  $proxy_bypass_list   = undef,
  $proxy_host          = undef,
  $proxy_pass          = undef,
  $proxy_port          = undef,
  $proxy_user          = undef,
  $user                = 'root',
  $version             = 'latest',
) {

 # Validate String
  validate_string($account_token)

  validate_string($group)

  validate_string($user)

  validate_re($log_level, [ '^DEBUG$', '^INFO$' ],
    'log_level must be \'DEBUG\' or \'INFO\'.')

  # Validate absolute paths.
  if $log_path != '' {
    validate_absolute_path($log_path)
  }

  # Validate integers
  if !is_integer($log_file_size) {
    fail('log_fie_size must be an integer.')
  }

  if !is_integer($num_log_files) {
    fail('num_log-files must be an integer.')
  }

  if $proxy_bypass != undef {
    if !is_string($proxy_bypass) {
      fail('proxy_bypass should be an string.')
    }
  }

  if $proxy_bypass_list != undef {
    if !is_string($proxy_bypass_list) {
      fail('proxy_bypass_list should be an string.')
    }
  }

  if $proxy_host != undef {
    validate_re($proxy_host,['^sc([0-9])+?.thousandeyes.com$'],
      'You must provide a valid host address.')
  }

  if $proxy_pass != undef {
    if !is_string($proxy_pass) {
      fail('proxy_pass should be an string.')
    }
  }

  if $proxy_port != undef {
    if !is_string($proxy_port) {
      fail('proxy_port should be an string.')
    }
  }

  if $proxy_user != undef {
    if !is_string($proxy_user) {
      fail('proxy_user should be an string.')
    }
  }

  # Packages
  validate_bool($agent_utils)

  validate_bool($browserbot)

  validate_bool($international_langs)

  anchor { 'teagent::begin': }
    class { '::teagent::agent': } ->
  anchor {'teagent::end': }

}
