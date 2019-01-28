class corp104_apache_exporter::service inherits corp104_apache_exporter {

  $real_provider = $corp104_apache_exporter::init_style ? {
    'sles'  => 'redhat',  # mimics puppet's default behaviour
    'sysv'  => 'redhat',  # all currently used cases for 'sysv' are redhat-compatible
    default => $corp104_apache_exporter::init_style,
  }

  exec { 'systemd-reload-apache-exporter':
    command     => "systemctl restart ${corp104_apache_exporter::service_name}",
    path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    refreshonly => true,
    require     => Exec['systemctl-daemon-reload'],
  }

  service { 'apache-exporter':
    ensure   => $corp104_apache_exporter::service_ensure,
    name     => $corp104_apache_exporter::service_name,
    enable   => $corp104_apache_exporter::service_enable,
    provider => $real_provider,
  }

}
