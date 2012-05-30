class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.integer :id
      # TODO: Investigate best was to store and retreive XML files
      t.string :xml

      t.timestamps
    end
  end

  def self.down
    drop_table :templates
  end
end
