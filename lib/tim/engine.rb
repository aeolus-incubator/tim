module Tim
  class Engine < Rails::Engine
    isolate_namespace Tim
    config.after_initialize do
      require "tim/application_controller"
    end
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
      g.template_engine :haml
    end

    # Load Host Decorator Classes
    config.to_prepare do |c|
      # Load everything under patches, exceptions and decorators dir
      [
        Dir[Rails.root.join('app', 'decorators', '**', '*_decorator.rb')],
        Dir[Tim::Engine.root.join('app', 'patches', '**', '*.rb')],
        Dir[Tim::Engine.root.join('app', 'exceptions', '**', '*.rb')]
      ].flatten.each do |f|
        Rails.application.config.cache_classes ? require(f) : load(f)
      end
    end

    # FIXME Normal method of instantiating observers does not seem to work in
    # rails engine,
    config.after_initialize do
      Tim::ProviderImageObserver.instance
      Tim::TargetImageObserver.instance
    end
  end
end