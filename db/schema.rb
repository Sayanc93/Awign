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

ActiveRecord::Schema.define(version: 20171029081726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interns", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "workforce_id"
    t.bigint "project_id"
    t.string "name", default: ""
    t.string "college", default: ""
    t.boolean "assigned", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["authentication_token"], name: "index_interns_on_authentication_token", unique: true
    t.index ["company_id"], name: "index_interns_on_company_id"
    t.index ["confirmation_token"], name: "index_interns_on_confirmation_token", unique: true
    t.index ["email"], name: "index_interns_on_email", unique: true
    t.index ["project_id"], name: "index_interns_on_project_id"
    t.index ["reset_password_token"], name: "index_interns_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_interns_on_unlock_token", unique: true
    t.index ["workforce_id"], name: "index_interns_on_workforce_id"
  end

  create_table "project_managers", force: :cascade do |t|
    t.bigint "company_id"
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["authentication_token"], name: "index_project_managers_on_authentication_token", unique: true
    t.index ["company_id"], name: "index_project_managers_on_company_id"
    t.index ["confirmation_token"], name: "index_project_managers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_project_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_project_managers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_project_managers_on_unlock_token", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.bigint "company_id"
    t.bigint "project_manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["project_manager_id"], name: "index_projects_on_project_manager_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "intern_id"
    t.bigint "project_id"
    t.string "name"
    t.string "description"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["intern_id"], name: "index_tasks_on_intern_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
  end

  create_table "workforces", force: :cascade do |t|
    t.bigint "project_manager_id"
    t.bigint "company_id"
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_workforces_on_company_id"
    t.index ["project_manager_id"], name: "index_workforces_on_project_manager_id"
  end

  add_foreign_key "interns", "companies"
  add_foreign_key "interns", "projects"
  add_foreign_key "interns", "workforces"
  add_foreign_key "project_managers", "companies"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "project_managers"
  add_foreign_key "tasks", "interns"
  add_foreign_key "tasks", "projects"
  add_foreign_key "workforces", "companies"
  add_foreign_key "workforces", "project_managers"
end
