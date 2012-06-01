require 'spec_helper'

module ImageManagement
  describe TargetImage do

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
          @mock_fti = {:id => "4cc3b024-5fe7-4b0b-934b-c5d463b990b0",
                       :status => "NEW",
                       :status_detail => "",
                       :percentage_complete => 0}

          ActiveResource::HttpMock.respond_to do |mock|
            mock.post("/imagefactory/target_images", {}, @mock_fti.to_json, 201, {})
          end
        end

        it "should create new target image with factory meta-data" do
          ti = Factory.build(:target_image)
          ti.stub(:template).and_return(Factory(:template))
          ti.save

          ti.factory_id.should == "4cc3b024-5fe7-4b0b-934b-c5d463b990b0"
          ti.status.should == "NEW"
          ti.status_detail.should == ""
          ti.progress.should == 0
        end
      end
    end
  end
end
