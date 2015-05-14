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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150418134222) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "name",            limit: 50
    t.string   "email",           limit: 100
    t.string   "username",        limit: 50,    null: false
    t.text     "password_digest", limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "bids", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.string   "min_bid",    limit: 7
    t.string   "max_bid",    limit: 7
    t.string   "value",      limit: 7
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "bids", ["product_id"], name: "index_bids_on_product_id", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "message",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "messages", ["product_id"], name: "index_messages_on_product_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.string   "title",              limit: 100
    t.text     "description",        limit: 65535
    t.string   "category",           limit: 100
    t.string   "sub_category",       limit: 100
    t.string   "product_type",       limit: 50
    t.string   "brand",              limit: 100
    t.integer  "price",              limit: 4
    t.boolean  "used",               limit: 1
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "can_bid",            limit: 1
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                       limit: 50
    t.string   "username",                   limit: 50,    null: false
    t.string   "city",                       limit: 50
    t.string   "mobile_no",                  limit: 10
    t.string   "email",                      limit: 100
    t.text     "password_digest",            limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "profile_image_file_name",    limit: 255
    t.string   "profile_image_content_type", limit: 255
    t.integer  "profile_image_file_size",    limit: 4
    t.datetime "profile_image_updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
