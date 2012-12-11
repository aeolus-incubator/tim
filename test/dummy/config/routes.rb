Rails.application.routes.draw do

  mount Tim::Engine => "/tim"

  # respond_options test path
  scope :module => "tim" do
    match "/respond_options_test/:id" => "base_images#respond_options_test"
  end 
end