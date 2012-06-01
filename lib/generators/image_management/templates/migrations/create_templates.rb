class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.integer :id
      # TODO: Investigate best way to store and retreive XML files
      t.text :xml

      t.timestamps
    end
  end

  def self.down
    drop_table :templates
  end
end
