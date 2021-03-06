# Parameterised Class: nginx::vhost::proxy
#
#   Nginx standard cache for offloading connections. Saves the
#   backend app server having to do it.
#
#   foreverything beyond it. Is probably therefore not compaitable
#   with other nginx modules.
#
# Parameters:
#   upstream_server/port are the apache/unicorn thing behind the
#   scenes.
#
#   port is the port to listen on, on all interfaces, so don't use 80
#   unless you want it to be the prime site.
#
#   magic is just if you want to include a chunk of other options as a
#   text blob.
#
# Actions:
#
# Requires:
#
# include nginx::server
#
# Sample Usage:
#
#  class { 'nginx::cache': port => 80 , upstream_port 8080 }
#
define nginx::vhost::proxy (
  $port                = '80',
  $priority            = '10',
  $template            = 'nginx/vhost-proxy.conf.erb',
  $upstream_server     = [],
  $upstream_https      = false,
  $servername          = '',
  $serveraliases       = undef,
  $ssl                 = false,
  $sslonly             = false,
  $ssl_port            = '443',
  $ssl_path            = $nginx::server::default_ssl_path,
  $ssl_cert            = $nginx::server::default_ssl_cert,
  $ssl_key             = $nginx::server::default_ssl_key,
  $ssl_redirect        = false,
  $magic               = '',
  $isdefaultvhost      = false,
  $proxy               = true,
  $forward_host_header = true,
  $set_host_header     = undef,
  $client_max_body_size = '10m',
  $lua_shared_dict  = $nginx::server::lua_shared_dict,
  $user_agent          = undef,
) {

  include nginx
  include nginx::params

  if $servername == '' {
    $srvname = $name
  } else {
    $srvname = $servername
  }

  if ($set_host_header and $forward_host_header) {
    fail("Cannot use both set_host_header and forward_host_header!")
  }

  file { "${nginx::params::vdir}/${priority}-${name}_proxy":
    content => template($template),
    owner   => 'root',
    group   => '0',
    mode    => '755',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

}
