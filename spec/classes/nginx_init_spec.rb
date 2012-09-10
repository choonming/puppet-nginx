require 'spec_helper'

describe 'nginx' do

  it { should include_class('nginx::service') }

  it { should contain_package('nginx').with(
    :ensure => 'present',
  )}

  it { should contain_file('/etc/nginx/nginx.conf').with(
    :ensure  => 'present',
    :owner   => 'root',
    :group   => 'root',
    :mode    => '0644',
    )}

end
