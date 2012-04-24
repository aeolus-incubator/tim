require 'spec_helper'

module ImageManagement
  describe Template do
    describe "Model relationships" do
      it 'should have one base image' do
        template = Template.new
        template.base_image = BaseImage.new
        template.save!
        Template.find(template).base_image.should == template.base_image
      end
    end
  end
end