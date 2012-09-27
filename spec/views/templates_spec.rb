require 'spec_helper'

module ImageManagement
  describe "/image_management/templates/_template" do
    before(:each) do
      view.stub(:template).and_return FactoryGirl.create(:template)
      [:template_url, :base_image].each do |method|
        view.stub(method)
      end
    end

    it "should render custom content partial when it is defined" do
      render
      view.should render_template(:partial => "_custom", :count => 1)
      Hash.from_xml(rendered)["template"].keys.include?("custom_content").should == true
    end

    it "should not fail to render when a content partial is not defined" do
      view.controller.stub(:template_exists?).and_return false
      render
      view.should render_template(:partial => "_custom", :count => 0)
    end
  end
end