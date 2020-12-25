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

ActiveRecord::Schema.define(version: 2020_12_25_184230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "currency_id", null: false
    t.string "title", null: false
    t.float "balance", default: 0.0, null: false
    t.uuid "last_transaction_id", null: false
    t.datetime "disabled_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "currencies", id: :string, force: :cascade do |t|
    t.string "label", null: false
  end

  create_table "roles", id: :string, force: :cascade do |t|
  end

  create_table "transaction_peer_types", id: :string, force: :cascade do |t|
    t.string "desc", null: false
  end

  create_table "transaction_peers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type_id", null: false
    t.uuid "inner_account_id"
    t.uuid "bank_detail_id"
  end

  create_table "transaction_status_histories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "transaction_id", null: false
    t.string "from_status_id", null: false
    t.string "to_status_id", null: false
    t.string "reason"
    t.datetime "created_at", null: false
  end

  create_table "transaction_statuses", id: :string, force: :cascade do |t|
    t.string "desc", null: false
  end

  create_table "transaction_types", id: :string, force: :cascade do |t|
    t.string "desc", null: false
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "amount", null: false
    t.string "currency_id", null: false
    t.uuid "from_id", null: false
    t.uuid "to_id", null: false
    t.string "type_id", null: false
    t.string "status_id", null: false
    t.uuid "parent_id"
    t.datetime "executed_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "role_id", default: "user", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "currencies"
  add_foreign_key "accounts", "users"
  add_foreign_key "transaction_peers", "accounts", column: "bank_detail_id"
  add_foreign_key "transaction_peers", "transaction_peer_types", column: "type_id"
  add_foreign_key "transaction_status_histories", "transaction_statuses", column: "from_status_id"
  add_foreign_key "transaction_status_histories", "transaction_statuses", column: "to_status_id"
  add_foreign_key "transactions", "transaction_peer_types", column: "type_id"
  add_foreign_key "transactions", "transaction_peers", column: "from_id"
  add_foreign_key "transactions", "transaction_peers", column: "to_id"
  add_foreign_key "transactions", "transaction_statuses", column: "status_id"
  add_foreign_key "transactions", "transactions", column: "parent_id"
  add_foreign_key "users", "roles"
end
