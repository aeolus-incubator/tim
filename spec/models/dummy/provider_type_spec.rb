require 'spec_helper'

describe ProviderType do
  describe "Dummy Model relationships" do
    before (:each) do
      Tim::TargetImage.any_instance.stub(:create_factory_target_image).and_return(true)
      Tim::TargetImage.any_instance.stub(:imported?).and_return(false)
    end

    it 'should have many target images' do
      provider_type = ProviderType.new
      2.times do
        provider_type.target_images << Tim::TargetImage.new
      end
      provider_type.save!
      ProviderType.find(provider_type).target_images.size.should == 2
    end
  end
end
