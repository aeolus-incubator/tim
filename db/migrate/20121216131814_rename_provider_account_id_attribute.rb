class RenameProviderAccountIdAttribute < ActiveRecord::Migration
  def up
    change_table :tim_provider_images do |t|
      t.rename :provider_account_id, :factory_provider_account_id
    end
  end

  def down
    change_table :tim_provider_images do |t|
      t.rename :factory_provider_account_id, :provider_account_id
    end
  end
end