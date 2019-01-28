# Make apache exporter version available as a fact

Facter.add(:apache_exporter) do
  confine { Facter.value(:kernel) != 'windows' }
  confine { Facter.value(:operatingsystem) != 'nexus' }
  setcode do
    if File.exist? '/usr/local/bin/apache-exporter'
      Facter::Core::Execution.exec('/usr/local/bin/apache-exporter -version 2>&1').match(/^apache_exporter\, version (\d+.\d+.\d+).*$/)[1]
    else Facter::Util::Resolution.which('apache-exporter')
      Facter::Core::Execution.exec('apache-exporter -version 2>&1').match(/^apache_exporter\, version (\d+.\d+.\d+).*$/)[1]
    end
  end
end
