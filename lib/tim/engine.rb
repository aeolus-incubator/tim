module Tim
  class Engine < Rails::Engine
    isolate_namespace Tim
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
      g.template_engine :haml
    end

    # Load Host Decorator Classes
    config.to_prepare do |c|
      Dir[Rails.root.join('app', 'decorators', '**', '*_decorator.rb')].each do |d|
        require d
      end

      # Load everything under patches dir
      Dir[Tim::Engine.root.join('app', 'patches', '**', '*.rb')].each do |p|
        require p
      end
    end
  end
end
