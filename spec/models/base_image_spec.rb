require 'spec_helper'

module Tim
  describe BaseImage do
    describe "Model relationships" do
      it 'should have many image versions' do
        base_image = FactoryGirl.build(:base_image_with_template)
        2.times do
          base_image.image_versions << ImageVersion.new
        end
        base_image.save
        BaseImage.find(base_image).image_versions.size.should == 2
      end

      it "should have one template" do
        base_image = FactoryGirl.build(:base_image)
        base_image.template = FactoryGirl.build(:template)
        base_image.save!
        BaseImage.find(base_image).template.should == base_image.template
      end
    end

    describe "Dummy model relationships" do
      it "should have one pool family" do
        base_image = FactoryGirl.build(:base_image_with_template)
        base_image.pool_family = PoolFamily.new
        base_image.save!
        BaseImage.find(base_image).pool_family.should == base_image.pool_family
      end

      it "should have one user" do
        base_image = FactoryGirl.build(:base_image_with_template)
        base_image.user = User.new
        base_image.save!
        BaseImage.find(base_image).user.should == base_image.user
      end
    end
  end
end
