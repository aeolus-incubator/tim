class CreateProviderImages < ActiveRecord::Migration
  def self.up
    create_table :provider_images do |t|
      t.integer :id
      t.string :factory_id
      t.integer :target_image_id
      t.integer :provider_account
      # The Cloud Specific ID. i.e. ami-12345678
      t.string :external_image_id
      t.boolean :snapshot

      t.timestamps
    end
  end

  def self.down
    drop_table :provider_images
  end
end
