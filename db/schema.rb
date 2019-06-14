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

ActiveRecord::Schema.define(version: 2019_06_14_144924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_suppliers", force: :cascade do |t|
    t.integer "product_id"
    t.integer "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_suppliers_on_product_id"
    t.index ["supplier_id"], name: "index_product_suppliers_on_supplier_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "product_uid"
    t.decimal "price", precision: 10, scale: 2
    t.text "product_title"
    t.boolean "is_active"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["product_uid"], name: "index_products_on_product_uid"
  end

  create_table "suppliers", force: :cascade do |t|
    t.integer "supplier_uid"
    t.string "supplier_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_uid"], name: "index_suppliers_on_supplier_uid"
  end

end
