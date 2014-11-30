# Define - teagent::agent::setting
define teagent::agent::setting(
  $value,
  $setting = $name,
  $order = '30'
) {

  teagent::setting {
    "teagent::agent::setting ${title}":
      setting => $setting,
      value   => $value,
      target  => [ 'teagent::agent' ],
      order   => $order,
      require => Package['te-agent']
  }

}
