# Define - teagent::agent::setting
define teagent::agent::setting($setting = $name, $value, $order = '30') {
  teagent::setting { "teagent::agent::setting ${title}":
    setting => $setting,
    value   => $value,
    target  => [ 'teagent::agent' ],
    order   => $order,
  }
}
