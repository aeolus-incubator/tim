class AddProviderAccountIdToProviderImage < ActiveRecord::Migration
  def self.up
    add_column :provider_images, :provider_account_id, :integer
  end

  def self.down
    remove_column :provider_images, :provider_account_id
  end
end
