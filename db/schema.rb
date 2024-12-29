# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_12_29_204550) do
  create_table "api_requests", force: :cascade do |t|
    t.string "target_type", null: false
    t.integer "target_id", null: false
    t.string "target_url", null: false
    t.boolean "success", null: false
    t.json "request_body"
    t.json "response_body"
    t.integer "response_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_type", "target_id"], name: "index_api_requests_on_target"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "wear", null: false
    t.integer "category", null: false
    t.boolean "stattrak", null: false
    t.boolean "souvenir", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "wear", "stattrak", "souvenir"], name: "index_items_on_name_and_wear_and_stattrak_and_souvenir", unique: true
  end

  create_table "listings", force: :cascade do |t|
    t.integer "market_page_id", null: false
    t.decimal "price", null: false
    t.decimal "float"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_page_id"], name: "index_listings_on_market_page_id"
    t.index ["uid"], name: "index_listings_on_uid", unique: true
  end

  create_table "market_pages", force: :cascade do |t|
    t.integer "market_id", null: false
    t.integer "item_id", null: false
    t.decimal "min_price"
    t.integer "quantity_available"
    t.integer "volume_sold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_market_pages_on_item_id"
    t.index ["market_id"], name: "index_market_pages_on_market_id"
  end

  create_table "markets", force: :cascade do |t|
    t.integer "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_markets_on_name", unique: true
  end

  add_foreign_key "listings", "market_pages"
  add_foreign_key "market_pages", "items"
  add_foreign_key "market_pages", "markets"
end
