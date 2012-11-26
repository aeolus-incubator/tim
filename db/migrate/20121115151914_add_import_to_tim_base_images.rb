class AddImportToTimBaseImages < ActiveRecord::Migration
  def change
    add_column :tim_base_images, :import, :boolean, :default => false
  end
end
