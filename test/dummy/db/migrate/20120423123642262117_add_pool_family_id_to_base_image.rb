class AddPoolFamilyIdToBaseImage < ActiveRecord::Migration
  def self.up
    add_column :base_images, :pool_family_id, :integer
  end

  def self.down
    remove_column :base_images, :pool_family_id
  end
end
