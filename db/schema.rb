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

ActiveRecord::Schema.define(version: 20171122151258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pitstops", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.float "price"
    t.float "rating"
    t.bigint "end_stage_id"
    t.bigint "start_stage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_stage_id"], name: "index_pitstops_on_end_stage_id"
    t.index ["start_stage_id"], name: "index_pitstops_on_start_stage_id"
  end

  create_table "stages", force: :cascade do |t|
    t.integer "stage_no"
    t.float "distance"
    t.float "elevation"
    t.date "stage_date
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_stages_on_trip_id"
  end

  create_table "trip_members", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_trip_members_on_trip_id"
    t.index ["user_id"], name: "index_trip_members_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "title"
    t.float "distance"
    t.float "elevation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "description"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "stages", "trips"
  add_foreign_key "trip_members", "trips"
  add_foreign_key "trip_members", "users"
end
