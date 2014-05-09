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
  $proxy_host = ''
  $proxy_port = '0'
  $ip_version = 'ipv4'
  $set_repo = true
}
