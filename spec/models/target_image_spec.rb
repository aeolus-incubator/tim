require 'spec_helper'

module ImageManagement
  describe TargetImage do
    describe "Model relationships" do
      it 'should have one images version' do
        target_image = TargetImage.new
        target_image.image_version = ImageVersion.new
        target_image.save!
        TargetImage.find(target_image).image_version.should == target_image.image_version
      end

      it 'should have many provider images' do
        target_image = TargetImage.new
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
        target_image.provider_type = ProviderType.new
        target_image.save!
        TargetImage.find(target_image).provider_type.should == target_image.provider_type
      end
    end
  end
end
