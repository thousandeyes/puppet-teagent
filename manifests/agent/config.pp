# private class
# Configures thousandeyes agent
class teagent::agent::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  datacat { 'teagent::agent':
    owner    => downcase($teagent::user),
    group    => downcase($teagent::group),
    mode     => '0400',
    path     => '/etc/te-agent.cfg',
    template => 'teagent/te-agent.cfg.erb',
  }

  teagent::agent::setting {
    'log-path':
      value => $teagent::log_path
  }

  teagent::agent::setting {
    'log-file-size':
      value => $teagent::log_file_size
  }

  teagent::agent::setting {
    'log-level':
      value => $teagent::log_level
  }

  teagent::agent::setting {
    'num-log-files':
      value => $teagent::num_log_files
  }

  teagent::agent::setting {
    'account-token':
      value => $teagent::account_token
  }

  teagent::agent::setting {
    'controller':
      value => $teagent::controller
  }

  teagent::agent::setting {
    'bind-addr':
      value => $teagent::bind_addr
  }

  teagent::agent::setting {
    'proxy-host':
      value => $teagent::proxy_host
  }

  teagent::agent::setting {
    'proxy-port':
      value => $teagent::proxy_port
  }

  teagent::agent::setting {
    'proxy-user':
      value => $teagent::proxy_user
  }

  teagent::agent::setting {
    'proxy-pass':
      value => $teagent::proxy_pass
  }

  teagent::agent::setting {
    'proxy-bypass-list':
      value => $teagent::proxy_bypass_list
  }

  anchor { 'teagent::agent::config::begin': }
  anchor { 'teagent::agent::config::end': }
}
