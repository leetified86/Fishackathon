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

ActiveRecord::Schema.define(version: 20160424010323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "catchcards", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.integer  "fish_id"
    t.string   "wild_or_hatchery"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "catchcards", ["fish_id"], name: "index_catchcards_on_fish_id", using: :btree
  add_index "catchcards", ["location_id"], name: "index_catchcards_on_location_id", using: :btree
  add_index "catchcards", ["user_id"], name: "index_catchcards_on_user_id", using: :btree

  create_table "fish", force: :cascade do |t|
    t.string   "fish_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "river"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "wild_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "catchcards", "fish"
  add_foreign_key "catchcards", "locations"
  add_foreign_key "catchcards", "users"
end
