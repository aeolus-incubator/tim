# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120423123114264114) do

  create_table "pool_families", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "provider_accounts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "provider_types", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tim_base_images", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "template_id"
    t.integer  "user_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "pool_family_id"
    t.boolean  "import",         :default => false
  end

  create_table "tim_image_versions", :force => true do |t|
    t.integer  "base_image_id"
    t.integer  "template_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "factory_base_image_id"
  end

  create_table "tim_provider_images", :force => true do |t|
    t.string   "factory_id"
    t.integer  "target_image_id"
    t.string   "provider"
    t.string   "external_image_id"
    t.string   "provider_account_id"
    t.boolean  "snapshot"
    t.string   "status"
    t.string   "status_detail"
    t.string   "progress"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "tim_target_images", :force => true do |t|
    t.string   "factory_id"
    t.integer  "image_version_id"
    t.string   "target"
    t.string   "status"
    t.string   "status_detail"
    t.string   "progress"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "provider_type_id"
    t.string   "build_method",     :default => "BARE_METAL"
  end

  create_table "tim_templates", :force => true do |t|
    t.text     "xml"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
