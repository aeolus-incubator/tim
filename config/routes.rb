Tim::Engine.routes.draw do
  resources :base_images
  resources :image_versions
  resources :target_images
  resources :provider_images
  resources :templates

  root :to => "base_images#index"
end
