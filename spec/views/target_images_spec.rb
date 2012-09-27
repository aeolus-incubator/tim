require 'spec_helper'

module ImageManagement
  describe "/image_management/target_images/_target_image" do
    before(:each) do
      view.stub(:target_image).and_return FactoryGirl.build(:target_image)
      [:target_image_url, :image_version_url].each do |method|
        view.stub(method)
      end
    end

    it "should render custom content partial when it is defined" do
      render
      view.should render_template(:partial => "_custom", :count => 1)
      Hash.from_xml(rendered)["target_image"].keys.include?("custom_content")
        .should == true
    end

    it "should not fail to render when a content partial is not defined" do
      view.controller.stub(:template_exists?).and_return false
      render
      view.should render_template(:partial => "_custom", :count => 0)
    end
  end
end