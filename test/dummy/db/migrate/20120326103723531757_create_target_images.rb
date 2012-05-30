class CreateTargetImages < ActiveRecord::Migration
  def self.up
    create_table :target_images do |t|
      t.integer :id
      t.string :factory_id
      t.integer :image_version_id
      t.string :target
      t.string :status
      t.string :status_detail
      t.string :progress # Factory Target Image percent_complete

      t.timestamps
    end
  end

  def self.down
    drop_table :target_images
  end
end
