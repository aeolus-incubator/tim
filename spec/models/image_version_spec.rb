require 'spec_helper'

module ImageManagement
  describe ImageVersion do
    describe "Model relationships" do
      before (:each) do
        TargetImage.any_instance.stub(:create_factory_target_image).and_return(true)
      end

      it 'should have one base image' do
        image_version = ImageVersion.new
        image_version.base_image = BaseImage.new
        image_version.save!
        ImageManagement::ImageVersion.find(image_version).base_image.should == image_version.base_image
      end

      it 'should have many target images' do
        image_version = ImageVersion.new
        2.times do
          image_version.target_images << TargetImage.new
        end
        image_version.save!
        ImageVersion.find(image_version).target_images.size.should == 2
      end
    end
  end
end
