require 'spec_helper'

describe ProviderAccount do
  describe "Dummy Model relationships" do
    before(:each) do
      Tim::ProviderImage.any_instance.stub(:create_factory_provider_image).and_return(true)
    end

    it 'should have many provider images' do
      provider_account = ProviderAccount.new
      2.times do
        provider_account.provider_images << Tim::ProviderImage.new
      end
      provider_account.save!
      ProviderAccount.find(provider_account).provider_images.size.should == 2
    end
  end
end
