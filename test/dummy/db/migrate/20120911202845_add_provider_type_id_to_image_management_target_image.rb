class AddProviderTypeIdToImageManagementTargetImage < ActiveRecord::Migration
  def change
    add_column :image_management_target_images, :provider_type_id, :integer
  end
end
