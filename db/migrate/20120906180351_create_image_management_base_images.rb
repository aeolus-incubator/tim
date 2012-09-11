class CreateImageManagementBaseImages < ActiveRecord::Migration
  def change
    create_table :image_management_base_images do |t|
      t.string :name
      t.string :description
      t.integer :template_id
      t.integer :user_id

      t.timestamps
    end
  end
end
