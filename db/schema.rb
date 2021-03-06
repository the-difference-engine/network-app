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

ActiveRecord::Schema.define(version: 20160926183031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.boolean  "active",                 default: false
    t.boolean  "hide_profile",           default: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["invitation_token"], name: "index_admins_on_invitation_token", unique: true, using: :btree
  add_index "admins", ["invitations_count"], name: "index_admins_on_invitations_count", using: :btree
  add_index "admins", ["invited_by_id"], name: "index_admins_on_invited_by_id", using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "batch_invitations", force: :cascade do |t|
    t.string   "unparsed_emails"
    t.string   "invitee_type"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cohort_cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employer_email_records", force: :cascade do |t|
    t.integer  "employer_id"
    t.integer  "student_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "employers", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.string   "rep_first_name"
    t.string   "rep_last_name"
    t.string   "rep_phone"
    t.string   "rep_email"
    t.string   "website"
    t.string   "city"
    t.string   "state"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       default: 0
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.boolean  "currently_hiring",       default: false
    t.string   "hiring_timeline"
    t.integer  "number_of_positions"
    t.string   "company_size"
    t.boolean  "active",                 default: false
    t.boolean  "allow_emails",           default: false
    t.boolean  "hide_profile",           default: false
  end

  add_index "employers", ["email"], name: "index_employers_on_email", unique: true, using: :btree
  add_index "employers", ["invitation_token"], name: "index_employers_on_invitation_token", unique: true, using: :btree
  add_index "employers", ["invitations_count"], name: "index_employers_on_invitations_count", using: :btree
  add_index "employers", ["invited_by_id"], name: "index_employers_on_invited_by_id", using: :btree
  add_index "employers", ["reset_password_token"], name: "index_employers_on_reset_password_token", unique: true, using: :btree

  create_table "employers_industries", id: false, force: :cascade do |t|
    t.integer "employer_id", null: false
    t.integer "industry_id", null: false
  end

  create_table "employers_position_types", id: false, force: :cascade do |t|
    t.integer "employer_id",      null: false
    t.integer "position_type_id", null: false
  end

  create_table "employers_positions", id: false, force: :cascade do |t|
    t.integer "employer_id", null: false
    t.integer "position_id", null: false
  end

  create_table "employers_salary_ranges", id: false, force: :cascade do |t|
    t.integer "employer_id",     null: false
    t.integer "salary_range_id", null: false
  end

  create_table "employers_technologies", id: false, force: :cascade do |t|
    t.integer "employer_id",   null: false
    t.integer "technology_id", null: false
  end

  create_table "follow_up_lists", force: :cascade do |t|
    t.integer  "employer_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follow_up_students", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "follow_up_list_id"
    t.integer  "employer_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "industries_students", id: false, force: :cascade do |t|
    t.integer "industry_id", null: false
    t.integer "student_id",  null: false
  end

  create_table "position_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions_students", id: false, force: :cascade do |t|
    t.integer "position_id", null: false
    t.integer "student_id",  null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer "student_id"
    t.string  "name"
    t.text    "description"
    t.boolean "capstone",      default: false
    t.boolean "client_work",   default: false
    t.string  "github"
    t.string  "website"
    t.string  "screencast"
    t.string  "project_image"
  end

  create_table "projects_technologies", id: false, force: :cascade do |t|
    t.integer "project_id",    null: false
    t.integer "technology_id", null: false
  end

  create_table "salary_ranges", force: :cascade do |t|
    t.string   "salary_range"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "student_email_records", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "employer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "follow_up_list_id"
    t.string   "avatar"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "current_industry"
    t.date     "grad_date"
    t.string   "skill_1"
    t.string   "skill_2"
    t.string   "skill_3"
    t.string   "interest_1"
    t.string   "interest_2"
    t.string   "interest_3"
    t.text     "interview_1"
    t.text     "interview_2"
    t.text     "interview_3"
    t.string   "github"
    t.string   "blog"
    t.string   "quote"
    t.boolean  "seeking_employment",     default: false
    t.string   "resume"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",       default: 0
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "linked_in"
    t.string   "current_city"
    t.string   "current_state"
    t.boolean  "active",                 default: false
    t.text     "about_me"
    t.string   "interview_q1"
    t.string   "interview_q2"
    t.string   "interview_q3"
    t.string   "personal_website"
    t.boolean  "hide_profile",           default: false
  end

  add_index "students", ["email"], name: "index_students_on_email", unique: true, using: :btree
  add_index "students", ["invitation_token"], name: "index_students_on_invitation_token", unique: true, using: :btree
  add_index "students", ["invitations_count"], name: "index_students_on_invitations_count", using: :btree
  add_index "students", ["invited_by_id"], name: "index_students_on_invited_by_id", using: :btree
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true, using: :btree

  create_table "students_technologies", id: false, force: :cascade do |t|
    t.integer "student_id",    null: false
    t.integer "technology_id", null: false
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
