class CreateImageVersions < ActiveRecord::Migration
  def self.up
    create_table :image_versions do |t|
      t.integer :id
      t.integer :base_image_id
      t.integer :template_id

      t.timestamps
    end
  end

  def self.down
    drop_table :image_versions
  end
end
