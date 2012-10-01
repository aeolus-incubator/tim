require "spec_helper"

module ImageManagement
  describe TemplatesController, :type => :controller do
    describe "Controller Decorator Pattern" do
      it "should allow overriding of instance variables in before filter" do
        ImageManagement::Template.stub(:limit).and_return("test")
        get :index
        controller.instance_variable_get(:@templates).should == "test"
      end
    end
  end
end