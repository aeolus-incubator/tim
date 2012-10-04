class CreateTimTemplates < ActiveRecord::Migration
  def change
    create_table :tim_templates do |t|
      t.text :xml

      t.timestamps
    end
  end
end
