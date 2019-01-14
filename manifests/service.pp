class corp104_apache_status_exporter::service inherits corp104_apache_status_exporter {

  $real_provider = $corp104_apache_status_exporter::init_style ? {
    'sles'  => 'redhat',  # mimics puppet's default behaviour
    'sysv'  => 'redhat',  # all currently used cases for 'sysv' are redhat-compatible
    default => $corp104_apache_status_exporter::init_style,
  }

  service { $corp104_apache_status_exporter::service_name:
    ensure   => $corp104_apache_status_exporter::service_ensure,
    name     => $corp104_apache_status_exporter::service_name,
    enable   => $corp104_apache_status_exporter::service_enable,
    provider => $real_provider,
  }

}
