class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.integer :id
      # URI used to locate the file on disk/remote
      t.string :location

      t.timestamps
    end
  end

  def self.down
    drop_table :templates
  end
end
