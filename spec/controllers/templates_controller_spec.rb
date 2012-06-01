require "spec_helper"

module ImageManagement
  describe TemplatesController do
    render_views

    describe "Templates API" do
      before(:each) do
        send_and_accept_xml
      end

      describe "Create Template" do

        context "Success" do
           it "should return a new template as xml" do
            post :create, { :template => Factory(:template).attributes }
            response.code.should == "201"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["template"]
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            post :create, { :invalid_template => Factory(:template).attributes }
            response.code.should == "422"
          end
        end
      end
    end
  end
end