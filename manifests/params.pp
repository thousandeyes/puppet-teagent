# == Class: teagent::params
# Copyright © 2013 ThousandEyes, Inc.
#
# === Copyright
#
# Copyright © 2013 ThousandEyes, Inc.
#
class teagent::params {
  ### te-agent parameters
  $browserbot = false
  $agent_utils = false
  $international_langs = false
  $account_token = '<account-token>'
  $log_path = '/var/log'
  $log_file_size = '10'
  $proxy_host = ''
  $proxy_port = '0'
  $proxy_user = ''
  $proxy_pass = ''
  $ip_version = 'ipv4'
  $interface = ''
  $set_repo = true
}
