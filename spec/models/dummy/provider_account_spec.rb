require 'spec_helper'

describe ProviderAccount do
  describe "Dummy Model relationships" do
    before(:each) do
      Tim::ProviderImage.any_instance.stub(:create_factory_provider_image).and_return(true)
      Tim::TargetImage.any_instance.stub(:create_factory_target_image).and_return(true)
      Tim::ProviderImage.any_instance.stub(:imported?).and_return(false)
    end

    it 'should have many provider images' do
      provider_account = ProviderAccount.new
      2.times do
        provider_account.provider_images << FactoryGirl.build(:provider_image_with_full_tree)
      end
      provider_account.save!
      ProviderAccount.find(provider_account).provider_images.size.should == 2
    end
  end
end
