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

ActiveRecord::Schema.define(version: 2022_04_01_181023) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.integer "manufacturer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.integer "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "information"
    t.index ["region_id"], name: "index_cities_on_region_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "information"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments_cities", force: :cascade do |t|
    t.integer "department_id"
    t.integer "city_id"
    t.index ["city_id"], name: "index_departments_cities_on_city_id"
    t.index ["department_id"], name: "index_departments_cities_on_department_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.date "legal_date"
    t.string "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "paid"
    t.string "state"
    t.integer "status"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.bigint "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.bigint "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer "category_id"
    t.integer "city_id"
    t.integer "position"
    t.string "color"
    t.float "amount"
    t.integer "client_id"
    t.string "aasm_state"
    t.boolean "active", default: true
    t.string "shipping_status"
    t.text "picture_data"
    t.index ["category_id"], name: "index_invoices_on_category_id"
    t.index ["city_id"], name: "index_invoices_on_city_id"
  end

  create_table "invoices_items", id: false, force: :cascade do |t|
    t.integer "invoice_id"
    t.integer "item_id"
    t.index ["invoice_id"], name: "index_invoices_items_on_invoice_id"
    t.index ["item_id"], name: "index_invoices_items_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.integer "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "information"
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

end
