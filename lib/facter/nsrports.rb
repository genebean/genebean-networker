require 'facter'

Facter.add(:nsr_serviceports) do
  setcode do
    Facter::Util::Resolution.exec("/usr/bin/nsrports | grep Service | sed -e 's/Service Ports: //i' -e's/[[:space:]]*$//'")
  end
end

Facter.add(:nsr_connectionports) do
  setcode do
    Facter::Util::Resolution.exec("/usr/bin/nsrports | grep Connection | sed -e 's/Connection Ports: //i' -e's/[[:space:]]*$//'")
  end
end
