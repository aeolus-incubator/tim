require 'spec_helper'

describe ProviderAccount do
  describe "Dummy Model relationships" do
    it 'should have many provider images' do
      provider_account = ProviderAccount.new
      2.times do
        provider_account.provider_images << ImageManagement::ProviderImage.new
      end
      provider_account.save!
      ProviderAccount.find(provider_account).provider_images.size.should == 2
    end
  end
end
