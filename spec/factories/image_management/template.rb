FactoryGirl.define do
  factory :template, :class => ImageManagement::Template do
    location 'http://localhost:3000/templates/1'
  end
end