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

ActiveRecord::Schema.define(version: 2021_11_14_104620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "balance", precision: 8, scale: 2, default: "0.0"
    t.string "currency", default: "AED"
    t.string "encrypted_password", default: ""
    t.string "auth_token"
    t.index ["email"], name: "index_accounts_on_email"
    t.index ["phone_number"], name: "index_accounts_on_phone_number"
    t.index ["status"], name: "index_accounts_on_status"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.decimal "amount", precision: 8, scale: 2, default: "0.0"
    t.string "currency", default: "AED"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_id"], name: "index_transactions_on_receiver_id"
    t.index ["sender_id"], name: "index_transactions_on_sender_id"
  end

  add_foreign_key "transactions", "accounts", column: "receiver_id"
  add_foreign_key "transactions", "accounts", column: "sender_id"
end
