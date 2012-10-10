require 'spec_helper'

module Tim
  describe EntrypointController, :type => :controller do
    render_views
    Tim::Engine.routes.default_url_options = {:host => 'test.host'}

    context "XML format response for " do
      before do
        send_and_accept_xml
      end

      describe "#index" do
        before do
          get :index
        end

        it { response.should be_success }
        it { response.headers['Content-Type'].should include("application/xml") }
        it "should have all resources URLs" do
          resp = Hash.from_xml(response.body)
          api = resp['api']
          api['templates']['href'].should == templates_url
          api['base_images']['href'].should == base_images_url
          api['image_versions']['href'].should == image_versions_url
          api['target_images']['href'].should == target_images_url
          api['provider_images']['href'].should == provider_images_url
        end
      end
    end
  end
end
