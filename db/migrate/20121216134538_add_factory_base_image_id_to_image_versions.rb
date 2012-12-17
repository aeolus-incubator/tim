class AddFactoryBaseImageIdToImageVersions < ActiveRecord::Migration
  def change
    add_column :tim_image_versions, :factory_base_image_id, :string
  end
end