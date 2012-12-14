require 'spec_helper'

module Tim
  describe ProviderImage do
    before (:each) do
      TargetImage.any_instance.stub(:create_factory_target_image).and_return(true)
      Tim::ProviderImage.any_instance.stub(:imported?).and_return(false)
      Tim::TargetImage.any_instance.stub(:imported?).and_return(false)
    end

    describe "Model relationships" do
      it 'should have one target image' do
        provider_image = FactoryGirl.build(:provider_image)
        provider_image.target_image = FactoryGirl.build(:target_image_with_full_tree)
        provider_image.stub(:create_factory_provider_image).and_return(true)
        provider_image.save!
        ProviderImage.find(provider_image).target_image.should == provider_image.target_image
      end
    end

    describe "Dummy model relationships" do
      it "should have one provider account" do
        provider_image = FactoryGirl.build(:provider_image_with_full_tree)
        provider_image.provider_account = ProviderAccount.new
        provider_image.stub(:create_factory_provider_image).and_return(true)
        provider_image.save!
        ProviderImage.find(provider_image).provider_account.should == provider_image.provider_account
      end
    end

    describe "ImageFactory interactions" do
      describe "Successful Requests" do
        before(:each) do
          ImageFactory::ProviderImage.any_instance.stub(:save!)
          TargetImage.any_instance.stub(:factory_id).and_return("1234")
        end

        it "should create factory provider image and populate fields" do
          # Needed due to ActiveRecord::Associations::Association#target
          # name conflict
          target = mock(:target)
          target.stub(:target).and_return("mock")

          pi = FactoryGirl.build(:provider_image_with_full_tree)
          pi.target_image.target = target
          pi.should_receive(:populate_factory_fields)
          pi.save
        end

        it "should add factory fields to provider image" do
          status_detail = mock(:status_detail)
          status_detail.stub(:activity).and_return("Building")

          pi = FactoryGirl.build(:provider_image)
          pi.send(:populate_factory_fields, FactoryGirl
                                .build(:image_factory_provider_image,
                                       :status_detail => status_detail))

          pi.factory_id.should == "4cc3b024-5fe7-4b0b-934b-c5d463b990b0"
          pi.status.should == "New"
          pi.status_detail.should == "Building"
          pi.progress.should == "10"
          pi.provider.should == "MockSphere"
          pi.external_image_id.should == "mock-123456"
          pi.provider_account_id.should == "mock-account-123"
        end

        it "should not make a request to factory if the base image is imported" do
          Tim::ProviderImage.any_instance.stub(:imported?).and_return(true)
          ti = FactoryGirl.build(:provider_image_import)
          ti.should_not_receive(:create_factory_provider_image)
          ti.save
        end

        it "should make a request to factory if the target image build type is SNAPSHOT" do
          ti = FactoryGirl.build(:provider_image)
          ti.should_not_receive(:create_factory_provider_image)
          ti.save
        end
      end
    end
  end
end
