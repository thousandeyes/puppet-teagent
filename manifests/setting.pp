# private define - teagent::setting
define teagent::setting($setting, $value, $target, $order = '50') {
  datacat_fragment {
    "teagent::setting ${title}":
      target => $target,
      order  => $order,
      data   => hash([ $setting, $value ]),
  }
}
