require 'spec_helper'

describe ProviderType do
  describe "Dummy Model relationships" do
    it 'should have many target images' do
      provider_type = ProviderType.new
      2.times do
        provider_type.target_images << ImageManagement::TargetImage.new
      end
      provider_type.save!
      ProviderType.find(provider_type).target_images.size.should == 2
    end
  end
end
