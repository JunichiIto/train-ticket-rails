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

ActiveRecord::Schema.define(version: 20170710234011) do

  create_table "gates", force: :cascade do |t|
    t.string "name", null: false
    t.integer "station_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_gates_on_name", unique: true
    t.index ["station_number"], name: "index_gates_on_station_number", unique: true
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "fare", null: false
    t.integer "entered_gate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "exited_gate_id"
    t.index ["entered_gate_id"], name: "index_tickets_on_entered_gate_id"
    t.index ["exited_gate_id"], name: "index_tickets_on_exited_gate_id"
  end

end
