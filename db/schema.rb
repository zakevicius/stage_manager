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

ActiveRecord::Schema.define(version: 2021_05_08_120834) do

  create_table "logs", charset: "utf8mb4", force: :cascade do |t|
    t.string "action_made_by"
    t.string "action"
    t.bigint "stage_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stage_id"], name: "index_logs_on_stage_id"
  end

  create_table "stages", charset: "utf8mb4", force: :cascade do |t|
    t.integer "stage"
    t.integer "status", default: 0
    t.timestamp "claimed_since"
    t.string "last_deployment_made_by"
    t.string "actions"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "logs", "stages"
end
