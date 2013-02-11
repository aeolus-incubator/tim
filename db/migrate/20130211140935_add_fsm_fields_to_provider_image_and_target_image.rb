class AddFsmFieldsToProviderImageAndTargetImage < ActiveRecord::Migration
  def change
    add_column :tim_target_images, :fsm_create_state, :string
    add_column :tim_target_images, :fsm_create_state_message, :text
    add_column :tim_target_images, :fsm_delete_state, :string
    add_column :tim_target_images, :fsm_delete_state_message, :text

    add_column :tim_provider_images, :fsm_create_state, :string
    add_column :tim_provider_images, :fsm_create_state_message, :text
    add_column :tim_provider_images, :fsm_delete_state, :string
    add_column :tim_provider_images, :fsm_delete_state_message, :text
  end
end