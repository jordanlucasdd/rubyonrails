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

ActiveRecord::Schema.define(version: 2019_08_22_185731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "project_collaborators", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "user_id", null: false
    t.string "permissions", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer "gfp_id"
    t.integer "old_gfp_id"
    t.integer "old_ts_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "old_cc", limit: 255
    t.integer "responsible_for_approval_id"
    t.boolean "active_in_gfp"
  end

  create_table "time_sheets", force: :cascade do |t|
    t.integer "month"
    t.integer "year"
    t.integer "project_id"
    t.integer "user_id"
    t.decimal "hours", precision: 5, scale: 2
    t.integer "percentage"
    t.integer "old_ts_id"
    t.string "status"
    t.string "reason_for_disapproval"
    t.string "cost_center"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "employee_contract"
    t.datetime "approved_at"
    t.datetime "reproved_at"
    t.datetime "canceled_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "google_token"
    t.string "google_refresh_token"
    t.text "roles", default: [], array: true
    t.string "erp_id"
    t.datetime "last_login"
    t.integer "old_ts_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recent_projects", default: [], array: true
    t.string "avatar", limit: 400
  end

end
