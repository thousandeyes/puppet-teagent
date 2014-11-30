# private class
class teagent::agent::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

   service {
     'te-agent':
       ensure     => 'running',
       hasrestart => true,
       hasstatus  => true,
       enable     => true,
  }
}
