class CreateImageManagementImageVersions < ActiveRecord::Migration
  def change
    create_table :image_management_image_versions do |t|
      t.integer :base_image_id
      t.integer :template_id

      t.timestamps
    end
  end
end
