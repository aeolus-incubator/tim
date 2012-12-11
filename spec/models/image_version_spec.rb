require 'spec_helper'

module Tim
  describe ImageVersion do
    describe "Model relationships" do
      before (:each) do
        TargetImage.any_instance.stub(:create_factory_target_image).and_return(true)
        Tim::TargetImage.any_instance.stub(:imported?).and_return(false)
      end

      it 'should have one base image' do
        image_version = ImageVersion.new
        image_version.base_image = FactoryGirl.build(:base_image_with_template)
        image_version.save!
        ImageVersion.find(image_version).base_image.should == image_version.base_image
      end

      it 'should have many target images' do
        image_version = FactoryGirl.build(:image_version_with_full_tree)
        2.times do
          image_version.target_images << FactoryGirl.build(:target_image)
        end
        image_version.save!
        ImageVersion.find(image_version).target_images.size.should == 2
      end
    end
  end
end
