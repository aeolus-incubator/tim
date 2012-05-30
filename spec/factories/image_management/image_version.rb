module ImageManagement
  FactoryGirl.define do
    factory :image_version, :class => ImageManagement::ImageVersion do
      association :base_image, :factory => :base_image
    end
  end
end