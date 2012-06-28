module ImageManagement
  FactoryGirl.define do
    factory :image_version, :class => ImageManagement::ImageVersion do
    end

    factory :image_version_with_base_image, :parent => :image_version do
      association :base_image, :factory => :base_image
    end

    factory :image_version_with_full_tree, :parent => :image_version do
      association :base_image, :factory => :base_image_with_template
    end

    factory :image_version_with_target_images, :parent => :image_version_with_full_tree do
      after_create do |image_version|
        2.times do
          image_version.target_images << Factory(:target_image, :image_version => image_version)
        end
      end
    end
  end
end