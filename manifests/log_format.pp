# == Define: hmrc_nginx::log_format
#
define nginx::log_format($definition) {
  file { "${nginx::params::etcdir}/log_formats/${title}.conf":
    ensure  => present,
    content => template('nginx/log_format.conf.erb'),
    notify  => Service['nginx'],
    require => File["${nginx::params::etcdir}/log_formats"],
  }
}
