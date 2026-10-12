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

ActiveRecord::Schema[8.1].define(version: 2026_10_12_004818) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.string "name", null: false
    t.integer "kind", null: false
    t.boolean "on_budget", default: true, null: false
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_accounts_on_budget_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.string "name", null: false
    t.string "currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.bigint "category_group_id", null: false
    t.string "name", null: false
    t.integer "position"
    t.integer "goal_type"
    t.bigint "goal_amount_minor"
    t.date "goal_target_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_categories_on_budget_id"
    t.index ["category_group_id"], name: "index_categories_on_category_group_id"
  end

  create_table "category_groups", force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.string "name", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_category_groups_on_budget_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "budget_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_memberships_on_budget_id"
    t.index ["user_id", "budget_id"], name: "index_memberships_on_user_id_and_budget_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "monthly_allocations", force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.bigint "category_id", null: false
    t.date "budget_month", null: false
    t.bigint "assigned_minor", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id"], name: "index_monthly_allocations_on_budget_id"
    t.index ["category_id", "budget_month"], name: "index_monthly_allocations_on_category_id_and_budget_month", unique: true
    t.index ["category_id"], name: "index_monthly_allocations_on_category_id"
  end

  create_table "payees", force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id", "name"], name: "index_payees_on_budget_id_and_name", unique: true
    t.index ["budget_id"], name: "index_payees_on_budget_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "budget_id", null: false
    t.bigint "account_id", null: false
    t.bigint "payee_id"
    t.bigint "category_id"
    t.date "date", null: false
    t.bigint "amount_minor", null: false
    t.string "memo"
    t.integer "cleared", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["budget_id"], name: "index_transactions_on_budget_id"
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["payee_id"], name: "index_transactions_on_payee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "budgets", on_delete: :cascade
  add_foreign_key "categories", "budgets", on_delete: :cascade
  add_foreign_key "categories", "category_groups", on_delete: :restrict
  add_foreign_key "category_groups", "budgets", on_delete: :cascade
  add_foreign_key "memberships", "budgets"
  add_foreign_key "memberships", "users"
  add_foreign_key "monthly_allocations", "budgets", on_delete: :cascade
  add_foreign_key "monthly_allocations", "categories", on_delete: :cascade
  add_foreign_key "payees", "budgets", on_delete: :cascade
  add_foreign_key "transactions", "accounts", on_delete: :restrict
  add_foreign_key "transactions", "budgets", on_delete: :cascade
  add_foreign_key "transactions", "categories", on_delete: :restrict
  add_foreign_key "transactions", "payees", on_delete: :restrict
end
