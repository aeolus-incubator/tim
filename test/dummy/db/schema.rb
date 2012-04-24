# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120423123757262119) do

  create_table "base_images", :force => true do |t|
    t.integer  "environment"
    t.integer  "template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "pool_family_id"
  end

  create_table "image_versions", :force => true do |t|
    t.integer  "base_image_id"
    t.integer  "template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pool_families", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provider_accounts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provider_images", :force => true do |t|
    t.string   "factory_id"
    t.integer  "target_image_id"
    t.integer  "provider_account"
    t.string   "external_image_id"
    t.boolean  "snapshot"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "provider_account_id"
  end

  create_table "provider_types", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "target_images", :force => true do |t|
    t.string   "factory_id"
    t.integer  "image_version_id"
    t.string   "status"
    t.string   "status_details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "provider_type_id"
  end

  create_table "templates", :force => true do |t|
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
