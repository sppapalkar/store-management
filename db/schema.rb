# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_17_215504) do

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.string "cvv"
    t.integer "expiry_mm"
    t.integer "expiry_yy"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "quantity"
    t.integer "user_id"
    t.integer "items_id"
    t.index ["items_id"], name: "index_carts_on_items_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "tax_slab", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "brand", default: "", null: false
    t.integer "category_id", null: false
    t.integer "restricted_item", null: false
    t.integer "age_restricted_item", null: false
    t.integer "quantity", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: "", null: false
    t.string "phone", default: "", null: false
    t.date "date_of_birth"
    t.string "address", default: "", null: false
    t.string "apt", default: "", null: false
    t.string "city", default: "", null: false
    t.string "postal_code", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "users"
  add_foreign_key "carts", "items", column: "items_id"
  add_foreign_key "carts", "users"
  add_foreign_key "items", "categories"
end
