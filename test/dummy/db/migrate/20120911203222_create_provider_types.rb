class CreateProviderTypes < ActiveRecord::Migration
  def change
    create_table :provider_types do |t|
      t.timestamps
    end
  end
end
