require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  test "can access base images path" do
    visit base_images_path
  end

  test "can access image versions path" do
    visit image_versions_path
  end

  test "can access target images path" do
    visit target_images_path
  end

  test "can access provider images path" do
    visit provider_images_path
  end
  
  test "can access base template path" do
    visit templates_path
  end
end
