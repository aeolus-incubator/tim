class CreateImageManagementTemplates < ActiveRecord::Migration
  def change
    create_table :image_management_templates do |t|
      t.text :xml

      t.timestamps
    end
  end
end
