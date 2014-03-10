# Puppet-nginx

A puppet module to manage the nginx webserver.

## Prerequisites

- Puppet >= 3.1.0

## About this module

### Log formats
The only log format assumed by the module is the built-in `combined` format.
Other log formats are pluggable per proxy vhost, or at the top level by
setting `nginx::params::default_log_format` in Hiera.

We assume you want to keep your log formats private, so we have provided a
defined type called `nginx::log_format` that you can call from a client module.

#### Example
```puppet
class bigco_nginx(
  $log_formats = {}
  ) {
  include nginx::server
  validate_hash($log_formats)
  create_resources('nginx::log_format', $log_formats)
  # etc.
}
```

New log format files are created in the directory `/etc/nginx/log_formats` -
this is created by the `nginx::server` class and is read by the central
`nginx.conf` file before any log formats are required. See the template
`nginx.conf.erb` for more details.

## License

See [LICENSE](https://github.com/hmrc/puppet-nginx/LICENSE).
