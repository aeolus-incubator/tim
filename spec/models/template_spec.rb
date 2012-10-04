require 'spec_helper'

module Tim
  describe Template do
    describe "Model relationships" do
      it 'should have many base images' do
        template = Template.new
        2.times do
          template.base_images << BaseImage.new
        end
        template.save!
        Template.find(template).base_images.size.should == 2
      end
    end
  end
end