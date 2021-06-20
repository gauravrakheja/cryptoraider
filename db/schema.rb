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

ActiveRecord::Schema.define(version: 2021_06_20_093317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candle_dumps", force: :cascade do |t|
    t.bigint "wallet_id", null: false
    t.decimal "price", precision: 30, scale: 2
    t.datetime "occurred_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "high", precision: 30, scale: 14
    t.decimal "low", precision: 30, scale: 14
    t.index ["occurred_at", "wallet_id"], name: "index_candle_dumps_on_occurred_at_and_wallet_id", unique: true
    t.index ["wallet_id"], name: "index_candle_dumps_on_wallet_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "currency"
    t.decimal "units", precision: 30, scale: 14
    t.decimal "average_price", precision: 30, scale: 14
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency"], name: "index_wallets_on_currency", unique: true
  end

  add_foreign_key "candle_dumps", "wallets"
end
