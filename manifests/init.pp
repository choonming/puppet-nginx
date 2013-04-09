class nginx (
  $nginx_global_options = $nginx::params::nginx_global_options,
  $nginx_events_options = $nginx::params::nginx_events_options,
  $nginx_http_options   = $nginx::params::nginx_http_options,
) {
  
  include nginx::service
  
  package { 'nginx':
    ensure  => present,
  }
  
  file { '/etc/nginx/nginx.conf':
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
