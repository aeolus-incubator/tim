class CreatePoolFamilies < ActiveRecord::Migration
  def change
    create_table :pool_families do |t|
      t.timestamps
    end
  end
end
