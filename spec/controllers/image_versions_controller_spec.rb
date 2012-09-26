require "spec_helper"

module ImageManagement
  describe ImageVersionsController do
    render_views

    describe "Image Versions API" do
      before(:each) do
        send_and_accept_xml
        TargetImage.any_instance.stub(:create_factory_target_image).and_return(true)
      end

      describe "Create Image Version" do

        context "Success" do
           it "should return a new image version as xml" do
            post :create, { :image_version => {}}
            response.code.should == "201"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["image_version"]
          end

          it "should return a new image version with base image as xml" do
            post :create, { :image_version => {:base_image => {:name => "Name"}}}
            response.code.should == "201"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["image_version"]
            body["image_version"].keys.should =~ ["base_image", "id", "href", "target_images"]
            body["image_version"]["base_image"].keys.should =~ ["id", "href"]
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            post :create, { :invalid_image => FactoryGirl.build(:image_version).attributes }
            response.code.should == "422"
          end
        end
      end

      describe "Show Image Version" do
        context "Success" do
          it "should return an existing image version as XML" do
            image_version = FactoryGirl.create(:image_version_with_base_image)
            get :show, :id => image_version.id

            response.code.should == "200"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["image_version"]
            body["image_version"].keys.should =~ ["id", "href", "target_images", "base_image"]
          end

          it "should return an existing base image as XML with target images" do
            image_version = FactoryGirl.create(:image_version_with_target_images)
            get :show, :id => image_version.id

            response.code.should == "200"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["image_version"]
            body["image_version"].keys.should =~ ["base_image", "id", "href", "target_images"]
            body["image_version"]["target_images"]["target_image"].size.should == 2
          end
        end

        context "failure" do
          it "should return a not found response when an image version does not exist" do
            get :show, :id => -1
            response.code.should == "404"
          end
        end
      end

      describe "List Image Versions" do
        context "Success" do
          it "should return a list of existing base images as XML" do
            3.times do
              FactoryGirl.create(:image_version_with_base_image)
            end

            get :index

            body = Hash.from_xml(response.body)
            body.keys.should  == ["image_versions"]
            body["image_versions"]["image_version"].first.keys.should =~ ["id", "href"]
            body["image_versions"]["image_version"].size.should == ImageVersion.all.size
            response.code.should == "200"
          end
        end
      end

      describe "Delete Image Version" do
        context "Success" do
          it "should return a no content code when deleting an image version" do
            image_version = FactoryGirl.create(:image_version)
            delete :destroy, :id => image_version.id
            response.code.should == "204"

            expect { ImageVersion.find(image_version.id) }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end

        context "Failure" do
          it "should return a not found code when deleting an image version that does not exist" do
            delete :destroy, :id => -1
            response.code.should == "404"
          end
        end
      end

      describe "Update Image Version" do

        context "Success" do
           it "should return an updated image version as xml" do
            image_version = FactoryGirl.create(:image_version_with_full_tree)
            image_version.base_image = FactoryGirl.create(:base_image)
            put :update, :id => image_version.id, :image_version => image_version.attributes
            response.code.should == "200"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["image_version"]

            ImageVersion.find(image_version.id).base_image.should == image_version.base_image
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            image_version = FactoryGirl.create(:image_version)
            post :update, :id => image_version.id, :invalid_image => image_version.attributes
            response.code.should == "422"
          end

          it "should return a not found code when updating an image version that does not exist" do
            post :update, :id => -1, :image_version => FactoryGirl.build(:image_version).attributes
            response.code.should == "404"
          end
        end
      end
    end
  end
end
