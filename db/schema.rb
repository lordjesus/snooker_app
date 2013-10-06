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

ActiveRecord::Schema.define(version: 20131003223209) do

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "number_of_tables"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enters", force: true do |t|
    t.integer  "player_id"
    t.integer  "tournament_id"
    t.string   "note"
    t.integer  "rank"
    t.boolean  "lost_all"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enters", ["player_id", "tournament_id"], name: "index_enters_on_player_id_and_tournament_id", unique: true
  add_index "enters", ["player_id"], name: "index_enters_on_player_id"
  add_index "enters", ["tournament_id"], name: "index_enters_on_tournament_id"

  create_table "players", force: true do |t|
    t.string   "name"
    t.integer  "ranking_points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
  end

  create_table "tournaments", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "final_date"
    t.datetime "deadline"
    t.integer  "entry_fee"
    t.integer  "number_of_players"
    t.integer  "club_id"
    t.integer  "alternate_club_id"
    t.integer  "max_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.integer  "is_valid"
    t.integer  "user_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
