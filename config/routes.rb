Rails.application.routes.draw do
  resources :base_images
  resources :image_versions
  resources :target_images
  resources :provider_images
  resources :templates
end