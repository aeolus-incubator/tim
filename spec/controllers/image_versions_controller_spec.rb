require "spec_helper"

module ImageManagement
  describe ImageVersionsController do
    render_views

    describe "Image Versions API" do
      before(:each) do
        send_and_accept_xml
      end

      describe "Create Image Version" do

        context "Success" do
           it "should return a new image version as xml" do
            post :create, { :image_version => Factory(:image_version).attributes }
            response.code.should == "201"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["image_version"]
          end

          it "should return a new image version with base image as xml" do
            post :create, { :image_version => Factory(:image_version_with_base_image).attributes }
            response.code.should == "201"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["image_version"]
            body["image_version"].keys.should =~ ["base_image", "id", "href"]
            body["image_version"]["base_image"].keys.should =~ ["id", "href"]
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            post :create, { :invalid_image => Factory(:image_version).attributes }
            response.code.should == "422"
          end
        end
      end
    end
  end
end