require "spec_helper"

module ImageManagement
  describe TargetImagesController do
    render_views

    describe "Target Images API" do
      before(:each) do
        send_and_accept_xml
      end

      describe "Create Target Image" do
        before(:each) do
          ImageFactory::TargetImage.stub(:create).and_return(Factory.build(:image_factory_target_image))
          TargetImage.any_instance.stub(:template).and_return Factory(:template)
        end

        context "Success" do
          it "should return a new target image as xml" do
            post :create, { :target_image => Factory(:target_image).attributes }
            response.code.should == "201"

            body = Hash.from_xml(response.body)
            body.keys.should  == ["target_image"]
            body["target_image"].keys.should  =~ ["target", "status", "status_detail", "progress", "href", "id"]
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            post :create, { :invalid_image => Factory(:target_image).attributes }
            response.code.should == "422"
          end
        end
      end
    end
  end
end