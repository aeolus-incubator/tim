require 'rails/generators'
require 'rails/generators/migration'

class ImageManagementGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      # We use nano milli seconds here to avoid ID conflicts on multiple migrations
      time = Time.now.utc
      "#{time.strftime("%Y%m%d%H%M%S")}#{time.usec}"
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_file
    migration_template 'create_base_images.rb', 'db/migrate/create_base_images.rb'
    migration_template 'create_image_versions.rb', 'db/migrate/create_image_versions.rb'
    migration_template 'create_target_images.rb', 'db/migrate/create_target_images.rb'
    migration_template 'create_provider_images.rb', 'db/migrate/create_provider_images.rb'
    migration_template 'create_templates.rb', 'db/migrate/create_templates.rb'
  end
end