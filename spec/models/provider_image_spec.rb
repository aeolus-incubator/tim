require 'spec_helper'

module ImageManagement
  describe ProviderImage do
    before (:each) do
      TargetImage.any_instance.stub(:create_factory_target_image).and_return(true)
    end

    describe "Model relationships" do
      it 'should have one target image' do
        provider_image = ProviderImage.new
        provider_image.target_image = TargetImage.new
        provider_image.save!
        ProviderImage.find(provider_image).target_image.should == provider_image.target_image
      end
    end

    describe "Dummy model relationships" do
      it "should have one provider account" do
        provider_image = ProviderImage.new
        provider_image.provider_account = ProviderAccount.new
        provider_image.save!
        ProviderImage.find(provider_image).provider_account.should == provider_image.provider_account
      end
    end
  end
end
