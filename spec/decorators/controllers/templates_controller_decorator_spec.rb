require "spec_helper"

module Tim
  describe TemplatesController, :type => :controller do
    describe "Controller Decorator Pattern" do
      it "should allow overriding of instance variables in before filter" do
        Tim::Template.stub(:limit).and_return("test")
        get :index
        controller.instance_variable_get(:@templates).should == "test"
      end
    end
  end
end