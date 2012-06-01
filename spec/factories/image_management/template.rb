FactoryGirl.define do
  factory :template, :class => ImageManagement::Template do
    xml '<template><dummy><data></data></dummy></template>'
  end
end