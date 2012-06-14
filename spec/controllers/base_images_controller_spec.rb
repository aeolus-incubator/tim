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
            body["base_image"].keys.should =~ ["template", "id", "href", "name", "description", "image_versions"]
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

      describe "Show Base Image" do
        context "Success" do
          it "should return an existing base image as XML" do
            base_image = Factory.create(:base_image)
            get :show, :id => base_image.id

            response.code.should == "200"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["base_image"]
            body["base_image"].keys.should =~ ["id", "href", "name", "description", "image_versions"]
          end

          it "should return an existing base image as XML with template" do
            base_image = Factory.create(:base_image_with_template)
            get :show, :id => base_image.id

            response.code.should == "200"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["base_image"]
            body["base_image"].keys.should =~ ["template", "id", "href", "name", "description", "image_versions"]
            body["base_image"]["template"].keys.should =~ ["id", "href"]
          end

          it "should return an existing base image as XML with image versions" do
            base_image = Factory.create(:base_image_with_template)
            2.times do
              Factory.create(:image_version, :base_image => base_image)
            end

            get :show, :id => base_image.id

            response.code.should == "200"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["base_image"]
            body["base_image"].keys.should =~ ["image_versions", "template", "id", "href", "name", "description"]
            body["base_image"]["image_versions"]["image_version"].size.should == 2
          end
        end

        context "failure" do
          it "should return a not found response when an base image does not exist" do
            get :show, :id => -1
            response.code.should == "404"
          end
        end
      end
    end
  end
end