class CreateProviderAccounts < ActiveRecord::Migration
  def self.up
    create_table :provider_accounts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :provider_accounts
  end
end
