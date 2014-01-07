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

ActiveRecord::Schema.define(version: 20140107033508) do

  create_table "orderers", force: true do |t|
    t.string   "name"
    t.integer  "color_index", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "works", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.date     "claim_date"
    t.date     "receipt_date"
    t.text     "memo"
    t.integer  "orderer_id"
    t.integer  "worktype_id"
    t.decimal  "quote_amount"
    t.decimal  "receipt_amount"
    t.integer  "year_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "works", ["year_id", "claim_date"], name: "index_works_on_year_id_and_claim_date"
  add_index "works", ["year_id", "end_date"], name: "index_works_on_year_id_and_end_date"
  add_index "works", ["year_id", "orderer_id"], name: "index_works_on_year_id_and_orderer_id"
  add_index "works", ["year_id", "quote_amount"], name: "index_works_on_year_id_and_quote_amount"
  add_index "works", ["year_id", "receipt_amount"], name: "index_works_on_year_id_and_receipt_amount"
  add_index "works", ["year_id", "receipt_date"], name: "index_works_on_year_id_and_receipt_date"
  add_index "works", ["year_id", "start_date"], name: "index_works_on_year_id_and_start_date"
  add_index "works", ["year_id", "worktype_id"], name: "index_works_on_year_id_and_worktype_id"

  create_table "worktypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "years", force: true do |t|
    t.integer  "year",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "years", ["year"], name: "index_years_on_year", unique: true

end
