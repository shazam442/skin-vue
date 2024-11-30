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

ActiveRecord::Schema[7.2].define(version: 2024_11_30_193944) do
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

  create_table "markets", force: :cascade do |t|
    t.integer "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
