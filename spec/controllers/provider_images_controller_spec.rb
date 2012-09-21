require "spec_helper"

module ImageManagement
  describe ProviderImagesController do
    render_views

    describe "Provider Images API" do
      before(:each) do
        send_and_accept_xml
        TargetImage.any_instance.stub(:template).and_return(FactoryGirl.build(:template))
        ProviderImage.any_instance.stub(:create_factory_provider_image).and_return(true)
        TargetImage.any_instance.stub(:create_factory_target_image).and_return(true)
        @status_detail = mock(:status)
        @status_detail.stub(:activity).and_return("Building")
        ImageFactory::TargetImage.stub(:create).and_return(FactoryGirl.build(:image_factory_target_image, :status_detail => @status_detail))
      end

      describe "Create Provider Image" do
        before(:each) do
          ImageFactory::ProviderImage.stub(:create).and_return(FactoryGirl.build(:image_factory_provider_image))
        end

        context "Success" do
          it "should return a new provider image as xml" do
            provider_image = Factory(:provider_image_with_full_tree)
            post :create, { :provider_image => provider_image.attributes }
            response.code.should == "201"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["provider_image"]
            body["provider_image"].keys.should  =~ ["external_image_id", "provider",
              "snapshot", "status_detail", "progress", "href", "id","target_image", "status"]
            body["provider_image"]["target_image"]["id"].should == provider_image.target_image .id.to_s
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            post :create, { :invalid_image => FactoryGirl.build(:provider_image).attributes }
            response.code.should == "422"
          end
        end
      end

      describe "Show Provider Image" do
        context "Success" do
          it "should return an existing provider image as XML" do
            provider_image = FactoryGirl.create(:provider_image_with_full_tree)
            get :show, :id => provider_image.id

            response.code.should == "200"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["provider_image"]
            body["provider_image"].keys.should  =~ ["external_image_id", "provider",
              "snapshot", "status_detail", "progress", "href", "id","target_image", "status"]
            body["provider_image"]["target_image"]["id"].should == provider_image.target_image .id.to_s
          end
        end

        context "failure" do
          it "should return a not found response when an provider image does not exist" do
            get :show, :id => -1
            response.code.should == "404"
          end
        end
      end

      describe "List Image Versions" do
        context "Success" do
          it "should return a list of existing provider images as XML" do
            3.times do
              FactoryGirl.create(:provider_image)
            end

            get :index

            body = Hash.from_xml(response.body)
            body.keys.should  == ["provider_images"]
            body["provider_images"]["provider_image"].first.keys.should =~ ["id", "href"]
            response.code.should == "200"
          end
        end
      end

      describe "Delete Provider Image" do
        context "Success" do
          it "should return a no content code when deleting a provider image" do
            provider_image = FactoryGirl.create(:provider_image)
            delete :destroy, :id => provider_image.id
            response.code.should == "204"

            expect { ProviderImage.find(provider_image.id) }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end

        context "Failure" do
          it "should return a not found code when deleting a provider image" do
            delete :destroy, :id => -1
            response.code.should == "404"
          end
        end
      end

      describe "Update Provider Image" do

        context "Success" do
           it "should return an updated provider image as xml" do
            provider_image = FactoryGirl.create(:provider_image_with_full_tree)
            provider_image.target_image  = FactoryGirl.create(:target_image )
            post :update, :id => provider_image.id, :provider_image => provider_image.attributes
            response.code.should == "200"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["provider_image"]

            ProviderImage.find(provider_image.id).target_image.should == provider_image.target_image
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            provider_image = FactoryGirl.create(:provider_image)
            post :update, :id => provider_image.id, :invalid_image => provider_image.attributes
            response.code.should == "422"
          end

          it "should return a not found code when updating a Provider image that does not exist" do
            delete :update, :id => -1, :provider_image => FactoryGirl.create(:provider_image).attributes
            response.code.should == "404"
          end
        end
      end

      describe "Update Target Image via factory callback" do
        before(:each) do
          send_and_accept_json
        end

        it "should update provider image status attributes via json" do
          provider_image = FactoryGirl.create(:provider_image_with_full_tree)
          factory_attributes = {:percent_complete => "100", "status_detail" => {:activity => "Building Image"} }
          hash = provider_image.attributes.merge(factory_attributes)
          post :update, :id => provider_image.id, :provider_image => hash
          response.code.should == "200"

          body = JSON.parse(response.body)
          body.keys.should  == ["provider_image"]
          body["provider_image"]["status_detail"].should == "Building Image"
          body["provider_image"]["progress"].should == "100"
        end
      end
    end
  end
end
