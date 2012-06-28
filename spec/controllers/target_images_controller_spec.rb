require "spec_helper"

module ImageManagement
  describe TargetImagesController do
    render_views

    describe "Target Images API" do
      before(:each) do
        send_and_accept_xml
        TargetImage.any_instance.stub(:template).and_return(Factory(:template))
        TargetImage.any_instance.stub(:create_factory_target_image).and_return(true)
      end

      describe "Create Target Image" do
        before(:each) do
          ImageFactory::TargetImage.stub(:create).and_return(Factory.build(:image_factory_target_image))
          TargetImage.any_instance.stub(:template).and_return Factory(:template)
        end

        context "Success" do
          it "should return a new target image as xml" do
            target_image = Factory(:target_image_with_full_tree)
            post :create, { :target_image => target_image.attributes }
            response.code.should == "201"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["target_image"]
            body["target_image"].keys.should  =~ ["target", "status", "status_detail", "progress", "href", "id", "provider_images", "image_version"]
            body["target_image"]["image_version"]["id"].should == target_image.image_version.id.to_s
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            post :create, { :invalid_image => Factory(:target_image).attributes }
            response.code.should == "422"
          end
        end
      end

      describe "Show Target Image" do
        context "Success" do
          it "should return an existing target image as XML" do
            target_image = Factory.create(:target_image_with_full_tree)
            get :show, :id => target_image.id

            response.code.should == "200"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["target_image"]
            body["target_image"].keys.should =~ ["id", "href", "image_version", 
              "provider_images", "target", "status", "status_detail", "progress"]
          end
        end

        context "failure" do
          it "should return a not found response when an target image does not exist" do
            get :show, :id => -1
            response.code.should == "404"
          end
        end
      end

      describe "List Image Versions" do
        context "Success" do
          it "should return a list of existing target images as XML" do
            3.times do
              Factory.create(:target_image)
            end

            get :index

            body = Hash.from_xml(response.body)
            body.keys.should  == ["target_images"]
            body["target_images"]["target_image"].first.keys.should =~ ["id", "href"]
            response.code.should == "200"
          end
        end
      end

      describe "Delete Target Image" do
        context "Success" do
          it "should return a no content code when deleting a target image" do
            target_image = Factory(:target_image)
            delete :destroy, :id => target_image.id
            response.code.should == "204"

            expect { TargetImage.find(target_image.id) }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end

        context "Failure" do
          it "should return a not found code when deleting a target image" do
            delete :destroy, :id => -1
            response.code.should == "404"
          end
        end
      end

      describe "Update Target Image" do

        context "Success" do
           it "should return an updated target image as xml" do
            target_image = Factory(:target_image_with_full_tree)
            target_image.image_version = Factory(:image_version)
            post :update, :id => target_image.id, :target_image => target_image.attributes
            response.code.should == "200"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["target_image"]

            TargetImage.find(target_image.id).image_version.should == target_image.image_version
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            target_image = Factory(:target_image)
            post :update, :id => target_image.id, :invalid_image => target_image.attributes
            response.code.should == "422"
          end

          it "should return a not found code when updating a target image that does not exist" do
            delete :update, :id => -1, :target_image => Factory(:target_image).attributes
            response.code.should == "404"
          end
        end
      end

    end
  end
end