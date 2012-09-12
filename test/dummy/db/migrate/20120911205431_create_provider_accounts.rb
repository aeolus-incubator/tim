class CreateProviderAccounts < ActiveRecord::Migration
  def change
    create_table :provider_accounts do |t|
      t.timestamps
    end
  end
end
