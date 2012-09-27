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
      after(:create) do |image_version, evaluator|
        FactoryGirl.create_list(:target_image, 2, :image_version => image_version)
      end
    end
  end
end
