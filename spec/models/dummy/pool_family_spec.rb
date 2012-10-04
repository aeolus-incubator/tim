require 'spec_helper'

describe PoolFamily do
  describe "Dummy Model relationships" do
    it 'should have many base images' do
      pool_family = PoolFamily.new
      2.times do
        pool_family.base_images << Tim::BaseImage.new
      end
      pool_family.save!
      PoolFamily.find(pool_family).base_images.size.should == 2
    end
  end
end
