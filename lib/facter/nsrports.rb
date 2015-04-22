require 'facter'

if `pgrep nsrexecd` != ""
  Facter.add(:nsr_serviceports) do
    confine :kernel => [ 'Linux', ]
    setcode do
      Facter::Util::Resolution.exec("/usr/bin/nsrports | grep Service | sed -e 's/Service Ports: //i' -e's/[[:space:]]*$//'")
    end
  end
  Facter.add(:nsr_connectionports) do
    confine :kernel => [ 'Linux', ]
    setcode do
      Facter::Util::Resolution.exec("/usr/bin/nsrports | grep Connection | sed -e 's/Connection Ports: //i' -e's/[[:space:]]*$//'")
    end
  end
else
  Facter.add(:nsr_serviceports) do
    confine :kernel => [ 'Linux', ]
    setcode do
      'nsrexecd not running'
    end
  end
  Facter.add(:nsr_connectionports) do
    confine :kernel => [ 'Linux', ]
    setcode do
      'nsrexecd not running'
    end
  end
end

