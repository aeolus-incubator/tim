class AddPoolFamilyIdToImageManagementBaseImage < ActiveRecord::Migration
  def change
    add_column :image_management_base_images, :pool_family_id, :integer
  end
end
