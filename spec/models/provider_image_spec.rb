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
        provider_image.stub(:create_factory_provider_image).and_return(true)
        provider_image.save!
        ProviderImage.find(provider_image).target_image.should == provider_image.target_image
      end
    end

    describe "Dummy model relationships" do
      it "should have one provider account" do
        provider_image = ProviderImage.new
        provider_image.provider_account = ProviderAccount.new
        provider_image.stub(:create_factory_provider_image).and_return(true)
        provider_image.save!
        ProviderImage.find(provider_image).provider_account.should == provider_image.provider_account
      end
    end

    describe "ImageFactory interactions" do
      describe "Successful Requests" do
        before(:each) do
          status_detail = mock(:status_detail)
          status_detail.stub(:activity).and_return("Building")

          ImageFactory::ProviderImage.stub(:create).and_return(Factory.build(:image_factory_provider_image, :status_detail => status_detail))
          TargetImage.any_instance.stub(:factory_id).and_return("1234")
        end

        it "should create new target image with factory meta-data" do
          pi = Factory.create(:provider_image)

          pi.factory_id.should == "4cc3b024-5fe7-4b0b-934b-c5d463b990b0"
          pi.status.should == "New"
          pi.status_detail.should == "Building"
          pi.progress.should == "10"
          pi.provider.should == "MockSphere"
          pi.external_image_id.should == "mock-123456"
          pi.provider_account_id.should == "mock-account-123"
        end

      end
    end
  end
end
