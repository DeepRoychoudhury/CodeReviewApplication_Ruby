# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_21_235514) do

  create_table "customreviewrules", force: :cascade do |t|
    t.string "projectname"
    t.string "reviewtype"
    t.integer "numberoflinesincontroller"
    t.integer "numberoflinesinmodel"
    t.integer "numberoflinesinhelper"
    t.integer "numberoflinesinview"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_customreviewrules_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "notepad"
    t.string "notify"
    t.integer "project_id", null: false
    t.index ["project_id"], name: "index_notes_on_project_id"
  end

  create_table "page_masters", force: :cascade do |t|
    t.string "pagename"
    t.string "pagelink"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prj_reviews", force: :cascade do |t|
    t.string "ReviewType"
    t.string "ReviewValue"
    t.integer "project_id", null: false
    t.integer "review_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_prj_reviews_on_project_id"
    t.index ["review_id"], name: "index_prj_reviews_on_review_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "ProjectName"
    t.string "Path"
    t.string "Status"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.string "Folder_Name"
    t.string "Type_Of_File"
    t.string "FileName"
    t.integer "Error_Line_Number"
    t.string "Error_Description"
    t.integer "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_results_on_project_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "FileType"
    t.string "ReviewName"
    t.string "ReviewValue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "role_masters", force: :cascade do |t|
    t.string "rolename"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "role_pages", force: :cascade do |t|
    t.integer "role_master_id", null: false
    t.integer "page_master_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_master_id"], name: "index_role_pages_on_page_master_id"
    t.index ["role_master_id"], name: "index_role_pages_on_role_master_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_master_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_master_id"], name: "index_user_roles_on_role_master_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "customreviewrules", "users"
  add_foreign_key "notes", "projects"
  add_foreign_key "prj_reviews", "projects"
  add_foreign_key "prj_reviews", "reviews"
  add_foreign_key "projects", "users"
  add_foreign_key "results", "projects"
  add_foreign_key "role_pages", "page_masters"
  add_foreign_key "role_pages", "role_masters"
  add_foreign_key "user_roles", "role_masters"
  add_foreign_key "user_roles", "users"
end
