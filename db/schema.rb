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

ActiveRecord::Schema.define(version: 20161229194235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artworks", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "accepted",           default: false
    t.string   "status",             default: "Under Review"
    t.integer  "ratings_count",      default: 0,              null: false
    t.float    "average_rating"
    t.boolean  "flag",               default: false
  end

  create_table "comments", force: true do |t|
    t.text     "comment_text"
    t.integer  "document_id"
    t.integer  "user_id"
    t.integer  "artwork_id"
    t.boolean  "title_suggestion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "style"
    t.boolean  "accepted",          default: false
    t.string   "status",            default: "Under Review"
    t.integer  "ratings_count",     default: 0,              null: false
    t.float    "average_rating"
    t.boolean  "flag",              default: false
  end

  create_table "ratings", force: true do |t|
    t.integer "rating_val"
    t.integer "document_id"
    t.integer "user_id"
    t.integer "artwork_id"
  end

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.string   "school"
    t.integer  "grade"
    t.string   "teacher"
    t.text     "bio"
    t.boolean  "approved",               default: false
    t.integer  "ratings_count",          default: 0,     null: false
    t.integer  "accepted_doc_count",     default: 0,     null: false
    t.integer  "accepted_art_count",     default: 0,     null: false
    t.integer  "documents_count",        default: 0,     null: false
    t.integer  "artworks_count",         default: 0,     null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
