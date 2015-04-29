require 'facter'

Facter.add(:nsr_serviceports) do
  confine :kernel => [ 'Linux', ]
  setcode do
    if `pgrep nsrexecd` != ""
      (`/usr/bin/nsrports`).match(/Service ports: ([0-9]+-[0-9]+)/)[1]
    else
      'nsrexecd not running'
    end
  end
end

Facter.add(:nsr_connectionports) do
  confine :kernel => [ 'Linux', ]
  setcode do
    if `pgrep nsrexecd` != ""
      (`/usr/bin/nsrports`).match(/Connection ports: ([0-9]+-[0-9]+)/)[1]
    else
      'nsrexecd not running'
    end
  end
end
