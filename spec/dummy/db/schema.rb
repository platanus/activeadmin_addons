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

ActiveRecord::Schema.define(version: 20180222225709) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "cars", force: :cascade do |t|
    t.string  "name",            limit: 255
    t.integer "year"
    t.integer "manufacturer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "information"
  end

  add_index "cities", ["region_id"], name: "index_cities_on_region_id"

  create_table "countries", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "information"
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "legal_date"
    t.string   "number",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid"
    t.string   "state",                   limit: 255
    t.integer  "status"
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "photo_file_name",         limit: 255
    t.string   "photo_content_type",      limit: 255
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "category_id"
    t.integer  "city_id"
    t.integer  "position"
    t.string   "color",                   limit: 255
    t.float    "amount"
    t.integer  "client_id"
    t.string   "aasm_state",              limit: 255
    t.boolean  "active",                              default: true
    t.string   "shipping_status"
  end

  add_index "invoices", ["category_id"], name: "index_invoices_on_category_id"
  add_index "invoices", ["city_id"], name: "index_invoices_on_city_id"

  create_table "invoices_items", id: false, force: :cascade do |t|
    t.integer "invoice_id"
    t.integer "item_id"
  end

  add_index "invoices_items", ["invoice_id"], name: "index_invoices_items_on_invoice_id"
  add_index "invoices_items", ["item_id"], name: "index_invoices_items_on_item_id"

  create_table "items", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "information"
  end

  add_index "regions", ["country_id"], name: "index_regions_on_country_id"

end
