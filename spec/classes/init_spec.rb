require 'spec_helper'
describe 'networker' do
  on_supported_os.each do |os, facts|
    context "on #{os} with defaults" do
      let(:facts) do
        facts.merge({
          :nsr_connectionports => '7937',
        })
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('networker') }
      it { is_expected.to contain_class('networker::install') }
      it { is_expected.to contain_class('networker::config') }
      it { is_expected.to contain_class('networker::service') }
    end
  end
end
