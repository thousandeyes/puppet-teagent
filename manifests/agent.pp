# Private class
# This class installs/configures thousandeyes agent
class teagent::agent {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  anchor { 'teagent::agent::begin': } ->
  class { '::teagent::agent::install': } ->
  class { '::teagent::agent::config': } ~>
  class { '::teagent::agent::service': } ->
  anchor { 'teagent::agent::end': }
}
