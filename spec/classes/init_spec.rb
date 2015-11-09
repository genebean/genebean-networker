require 'spec_helper'
describe 'networker' do

  context 'with defaults for all parameters' do
    let :facts do
      {
        :osfamily => 'RedHat',
        :kernel   => 'Linux',
      }
    end

    it { should contain_class('networker') }
  end
end
