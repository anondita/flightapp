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

ActiveRecord::Schema.define(version: 2019_02_07_124310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.string "pnr"
    t.integer "seats"
    t.string "seatclass"
    t.date "dateofjourney"
    t.string "source"
    t.string "destination"
    t.bigint "user_id"
    t.bigint "flight_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "totalprice"
    t.index ["flight_id"], name: "index_bookings_on_flight_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.integer "seat"
    t.integer "row"
    t.integer "price"
    t.integer "total"
    t.integer "emergency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "flight_id"
    t.integer "availability"
    t.index ["flight_id"], name: "index_businesses_on_flight_id"
  end

  create_table "economies", force: :cascade do |t|
    t.integer "seat"
    t.integer "row"
    t.integer "price"
    t.integer "total"
    t.integer "emergency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "flight_id"
    t.integer "availability"
    t.index ["flight_id"], name: "index_economies_on_flight_id"
  end

  create_table "firstclasses", force: :cascade do |t|
    t.integer "seat"
    t.integer "row"
    t.integer "price"
    t.integer "total"
    t.integer "emergency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "flight_id"
    t.integer "availability"
    t.index ["flight_id"], name: "index_firstclasses_on_flight_id"
  end

  create_table "flights", force: :cascade do |t|
    t.string "name"
    t.string "source"
    t.string "destination"
    t.time "depart"
    t.time "arrive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "dateofflight"
  end

  create_table "seatofbookings", force: :cascade do |t|
    t.integer "seatnumber"
    t.bigint "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_seatofbookings_on_booking_id"
  end

  create_table "seats", force: :cascade do |t|
    t.string "seatclass"
    t.string "pnr"
    t.integer "seatnumber"
    t.string "seattype"
    t.bigint "price"
    t.integer "booking_id"
    t.bigint "flight_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "available", default: true
    t.index ["flight_id"], name: "index_seats_on_flight_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "flights"
  add_foreign_key "bookings", "users"
  add_foreign_key "businesses", "flights"
  add_foreign_key "economies", "flights"
  add_foreign_key "firstclasses", "flights"
  add_foreign_key "seatofbookings", "bookings"
  add_foreign_key "seats", "flights"
end
