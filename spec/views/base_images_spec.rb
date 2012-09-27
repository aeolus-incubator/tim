require 'spec_helper'

module ImageManagement
  describe "/image_management/base_images/_base_image" do
    before(:each) do
      view.stub(:base_image).and_return FactoryGirl.create(:base_image)
      view.stub(:base_image_url)
    end

    it "should render custom content partial when it is defined" do
      render
      view.should render_template(:partial => "_custom", :count => 1)
      Hash.from_xml(rendered)["base_image"].keys.include?("custom_content")
        .should == true
    end

    it "should not fail to render when a content partial is not defined" do
      view.controller.stub(:template_exists?).and_return false
      render
      view.should render_template(:partial => "_custom", :count => 0)
    end
  end
end