module Tim
  class Engine < Rails::Engine
    isolate_namespace Tim
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
      g.template_engine :haml
    end
  end
end
