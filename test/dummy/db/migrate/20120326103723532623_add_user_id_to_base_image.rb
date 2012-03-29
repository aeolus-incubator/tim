class AddUserIdToBaseImage < ActiveRecord::Migration
  def self.up
    add_column :base_images, :user_id, :integer
  end

  def self.down
    remove_column :base_images, :user_id
  end
end
