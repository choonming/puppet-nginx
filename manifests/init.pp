class nginx (
  $nginx_global_options = undef,
  $nginx_events_options = undef,
  $nginx_http_options   = undef,
) {
  
  include concat::setup
  include nginx::params
  include nginx::service

  if $nginx_global_options != undef {
    $nginx_global_options_real = $nginx_global_options
  } else {
    $nginx_global_options_real = $nginx::params::nginx_global_options
  }

  if $nginx_events_options != undef {
    $nginx_events_options_real = $nginx_events_options
  } else {
    $nginx_events_options_real = $nginx::params::nginx_events_options
  }

  if $nginx_http_options != undef {
    $nginx_http_options_real = $nginx_http_options
  } else {
    $nginx_http_options_real = $nginx::params::nginx_http_options
  }

  
  package { 'nginx':
    ensure  => present,
  }
  
  concat { '/etc/nginx/nginx.conf':
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
    require => Package['nginx'],
    notify  => Class['nginx::service'],
  }
  
  concat::fragment { 'nginx-base':
    target  => '/etc/nginx/nginx.conf',
    order   => '10',
    content =>  template('nginx/nginx-base.erb'),
    notify  => Class['nginx::service'],
  }

}
