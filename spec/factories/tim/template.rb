FactoryGirl.define do
  factory :template, :class => Tim::Template do
    xml '<template><dummy><data></data></dummy></template>'
  end
end
