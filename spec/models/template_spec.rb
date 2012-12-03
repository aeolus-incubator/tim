require 'spec_helper'

module Tim
  describe Template do
    describe "Model relationships" do
      it 'should have many base images' do
        template = FactoryGirl.build(:template)
        2.times do
          template.base_images << BaseImage.new
        end
        template.save!
        Template.find(template).base_images.size.should == 2
      end
    end

    describe "XML helper methods" do
      it 'should return os struct' do
        os = FactoryGirl.build(:template).os
        os.name.should == 'Fedora'
        os.version.should == '15'
        os.arch.should == 'x86_64'
      end
    end
  end
end
