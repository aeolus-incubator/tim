class AddProviderTypeIdToTargetImage < ActiveRecord::Migration
  def self.up
    add_column :target_images, :provider_type_id, :integer
  end

  def self.down
    remove_column :target_images, :provider_type_id
  end
end
