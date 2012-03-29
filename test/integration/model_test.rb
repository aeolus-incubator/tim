require 'test_helper'

class ModelTest < ActiveSupport::IntegrationCase
  test "should extend base image model with user relation" do 
    base_image = ImageManagement::BaseImage.new
    user = User.new

    base_image.user = user
    base_image.save!

    assert_equal(ImageManagement::BaseImage.find(base_image).user, user)
  end
end