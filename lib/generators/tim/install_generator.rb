require 'rails/generators'

module Tim
  class InstallGenerator < Rails::Generators::Base
    desc "Copy Tim default files"
    source_root File.expand_path('../templates', __FILE__)

    def copy_config
      copy_file "tim.rb", "config/initializers/tim.rb"
    end
    def show_readme
      readme 'README' if behavior == :invoke
    end
  end
end
