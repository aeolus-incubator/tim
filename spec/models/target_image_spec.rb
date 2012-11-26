require 'spec_helper'

module Tim
  describe TargetImage do

    before (:each) do
      Tim::TargetImage.any_instance.stub(:imported?).and_return(false)
    end
    #TODO FIX: A bug in RSpec V2.1 means that any_instance propogates across context therefore we are  stubbing each 
    #target_image.   This bug is fixed in RSpec V2.6 
    describe "Model relationships" do
      it 'should have one images version' do
        target_image = TargetImage.new
        target_image.stub(:create_factory_target_image).and_return(true)
        target_image.image_version = ImageVersion.new
        target_image.save!
        TargetImage.find(target_image).image_version.should == target_image.image_version
      end

      it 'should have many provider images' do
        target_image = TargetImage.new
        target_image.stub(:create_factory_target_image).and_return(true)
        ProviderImage.any_instance.stub(:create_factory_provider_image).and_return(true)
        2.times do
          target_image.provider_images << ProviderImage.new
        end
        target_image.save!
        TargetImage.find(target_image).provider_images.size.should == 2
      end
    end

    describe "Dummy model relationships" do
      it "should have one provider type" do
        target_image = TargetImage.new
        target_image.stub(:create_factory_target_image).and_return(true)
        target_image.provider_type = ProviderType.new
        target_image.save!
        TargetImage.find(target_image).provider_type.should == target_image.provider_type
      end
    end

    describe "ImageFactory interactions" do
      describe "Successful Requests" do
        before(:each) do
          ImageFactory::TargetImage.any_instance.stub(:save!)
        end

        it "should create factory provider image and populate fields" do
          # Needed due to ActiveRecord::Associations::Association#target
          # name conflict
          target = mock(:target)
          target.stub(:target).and_return("mock")

          ti = FactoryGirl.build(:target_image_with_full_tree)
          ti.target = target
          ti.should_receive(:populate_factory_fields)
          ti.save
        end

        it "should add factory fields to provider image" do
          status_detail = mock(:status_detail)
          status_detail.stub(:activity).and_return("Building")

          ti = FactoryGirl.build(:target_image_with_full_tree)
          ti.send(:populate_factory_fields, FactoryGirl
                                .build(:image_factory_target_image,
                                       :status_detail => status_detail))

          ti.factory_id.should == "4cc3b024-5fe7-4b0b-934b-c5d463b990b0"
          ti.status.should == "NEW"
          ti.status_detail.should == "Building"
          ti.progress.should == "0"
        end

        it "should not make a request to factory if the base image is imported" do
          Tim::TargetImage.any_instance.stub(:imported?).and_return(true)
          ti = FactoryGirl.build(:target_image_import)
          ti.should_not_receive(:create_factory_target_image)
          ti.save
        end
      end
    end
  end
end
