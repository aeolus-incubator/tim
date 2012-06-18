class CreateBaseImages < ActiveRecord::Migration
  def self.up
    create_table :base_images do |t|
      t.integer :id
      t.string :name
      t.string :description
      t.integer :template_id

      t.timestamps
    end
  end

  def self.down
    drop_table :base_images
  end
end
