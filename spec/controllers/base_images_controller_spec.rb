require "spec_helper"

module ImageManagement
  describe BaseImagesController do
    render_views

    describe "Base Images API" do
      before(:each) do
        send_and_accept_xml
      end

      describe "Create Base Image" do

        context "Success" do
           it "should return a new base image as xml" do
            post :create, { :base_image => Factory(:base_image).attributes }
            response.code.should == "201"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["base_image"]
          end

          it "should return a new base image with template as xml" do
            post :create, { :base_image => Factory(:base_image_with_template).attributes }
            response.code.should == "201"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["base_image"]
            body["base_image"].keys.should =~ ["template", "id", "href"]
            body["base_image"]["template"].keys.should =~ ["id", "href"]
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            post :create, { :invalid_image => Factory(:base_image).attributes }
            response.code.should == "422"
          end
        end
      end
    end
  end
end