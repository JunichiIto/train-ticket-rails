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

ActiveRecord::Schema[7.0].define(version: 2023_02_18_023322) do
  create_table "gates", force: :cascade do |t|
    t.string "name", null: false
    t.integer "station_number", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_gates_on_name", unique: true
    t.index ["station_number"], name: "index_gates_on_station_number", unique: true
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "fare", null: false
    t.integer "entered_gate_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "exited_gate_id"
    t.index ["entered_gate_id"], name: "index_tickets_on_entered_gate_id"
    t.index ["exited_gate_id"], name: "index_tickets_on_exited_gate_id"
  end

end
