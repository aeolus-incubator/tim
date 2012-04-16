Rails.application.routes.draw do
  scope :as => 'image_management', :module => "image_management" do
    resources :base_images
    resources :image_versions
    resources :target_images
    resources :provider_images
    resources :templates
  end

  root :to => "image_management/base_images#index"
end