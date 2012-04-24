class CreatePoolFamilies < ActiveRecord::Migration
  def self.up
    create_table :pool_families do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :pool_families
  end
end
