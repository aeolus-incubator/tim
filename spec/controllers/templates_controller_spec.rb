require "spec_helper"

module Tim
  describe TemplatesController do
    render_views

    describe "Templates API" do

      before(:each) do
        send_and_accept_xml
        TemplatesController.any_instance.stub(:template_exists?).and_return false
      end

      describe "Create Template" do

        context "Success" do
           it "should return a new template as xml" do
             template = FactoryGirl.build(:template)
             request.env['RAW_POST_DATA'] = template.xml
             post :create

             response.code.should == "201"
             template_xml = ::Nokogiri::XML::Document.parse(response.body)
             template_xml.xpath("//template/*").to_xml
               .include?(template.xml_elements).should == true
             template_xml.xpath("//template/@*").map { |node| node.name}
               .should =~ ["id", "href"]
          end
        end

        context "failure" do
          it "should return a unprocessable entity error when the client sends invalid content" do
            request.env['RAW_POST_DATA'] = "<invalid_template></invalid_template>"
            post :create
            response.code.should == "422"
          end
        end
      end
    end
  end
end
