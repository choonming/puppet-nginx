class nginx::params {
  
  $nginx_global_options   = { 'user' => 'www-data',
                              'worker_processes' => '2',
                              'error_log' => '/var/log/nginx/error.log',
                              'pid' => '/var/run/nginx.pid',
                            }
                            
  $nginx_events_options   = { 'worker_connections' => '1024',
                              'multi_accept' => 'on',
                            }
                            
  $nginx_http_options     = { 'include' => '/etc/nginx/mime.types',
                              'default_type' =>  'application/octet-stream',
                              'access_log'  => '/var/log/nginx/access.log',
                              'sendfile'    => 'on',
                              'tcp_nopush'  => 'on',
                              'tcp_nodelay' => 'on',
                              'gzip'        => 'on',
                              'gzip_disable' => '"MSIE [1-6]\.(?!.*SV1)"',
                              'include' => '/etc/nginx/conf.d/*.conf',
                            }

}