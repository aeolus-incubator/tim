require 'spec_helper'

module ImageManagement
  describe "/image_management/provider_images/_provider_image" do
    before(:each) do
      ImageManagement::TargetImage.any_instance
        .stub(:create_factory_target_image)
      ImageManagement::TargetImage.any_instance.stub(:template)
        .and_return FactoryGirl.build(:template)

      view.stub(:provider_image).and_return FactoryGirl.build(:provider_image)
      [:provider_image_url, :target_image_url].each do |method|
        view.stub(method)
      end
    end

    it "should render custom content partial when it is defined" do
      render
      view.should render_template(:partial => "_custom", :count => 1)
      Hash.from_xml(rendered)["provider_image"].keys.include?("custom_content")
        .should == true
    end

    it "should not fail to render when a content partial is not defined" do
      view.controller.stub(:template_exists?).and_return false
      render
      view.should render_template(:partial => "_custom", :count => 0)
    end
  end
end