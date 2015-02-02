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

ActiveRecord::Schema.define(version: 20150119032951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["user_id", "name"], name: "index_categories_on_user_id_and_name", unique: true, using: :btree
  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "category_feeds", force: true do |t|
    t.integer  "feed_id",     null: false
    t.integer  "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_feeds", ["category_id"], name: "index_category_feeds_on_category_id", using: :btree
  add_index "category_feeds", ["feed_id", "category_id"], name: "index_category_feeds_on_feed_id_and_category_id", unique: true, using: :btree
  add_index "category_feeds", ["feed_id"], name: "index_category_feeds_on_feed_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "body",             null: false
    t.integer  "author_id",        null: false
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree
  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree

  create_table "entries", force: true do |t|
    t.text     "guid",         null: false
    t.string   "title"
    t.string   "link"
    t.text     "json",         null: false
    t.datetime "published_at", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["guid"], name: "index_entries_on_guid", unique: true, using: :btree

  create_table "feed_entries", force: true do |t|
    t.integer  "entry_id",   null: false
    t.integer  "feed_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feed_entries", ["entry_id", "feed_id"], name: "index_feed_entries_on_entry_id_and_feed_id", unique: true, using: :btree
  add_index "feed_entries", ["entry_id"], name: "index_feed_entries_on_entry_id", using: :btree
  add_index "feed_entries", ["feed_id"], name: "index_feed_entries_on_feed_id", using: :btree

  create_table "feeds", force: true do |t|
    t.string   "name",                       null: false
    t.string   "url",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "curated",    default: false
    t.integer  "curator_id"
  end

  add_index "feeds", ["curator_id"], name: "index_feeds_on_curator_id", using: :btree
  add_index "feeds", ["name"], name: "index_feeds_on_name", unique: true, using: :btree

  create_table "security_question_answers", force: true do |t|
    t.string   "answer_digest", null: false
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "security_question_answers", ["question_id"], name: "index_security_question_answers_on_question_id", using: :btree
  add_index "security_question_answers", ["user_id", "question_id"], name: "index_security_question_answers_on_user_id_and_question_id", unique: true, using: :btree
  add_index "security_question_answers", ["user_id"], name: "index_security_question_answers_on_user_id", using: :btree

  create_table "security_questions", force: true do |t|
    t.text     "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "security_questions", ["content"], name: "index_security_questions_on_content", unique: true, using: :btree

  create_table "user_feeds", force: true do |t|
    t.integer  "user_id",          null: false
    t.integer  "feed_id",          null: false
    t.string   "background_color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_feeds", ["feed_id"], name: "index_user_feeds_on_feed_id", using: :btree
  add_index "user_feeds", ["user_id", "feed_id"], name: "index_user_feeds_on_user_id_and_feed_id", unique: true, using: :btree
  add_index "user_feeds", ["user_id"], name: "index_user_feeds_on_user_id", using: :btree

  create_table "user_follows", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "watcher_id", null: false
    t.integer  "curator_id", null: false
  end

  add_index "user_follows", ["curator_id"], name: "index_user_follows_on_curator_id", using: :btree
  add_index "user_follows", ["watcher_id", "curator_id"], name: "index_user_follows_on_watcher_id_and_curator_id", unique: true, using: :btree
  add_index "user_follows", ["watcher_id"], name: "index_user_follows_on_watcher_id", using: :btree

  create_table "user_read_entries", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "entry_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_read_entries", ["entry_id"], name: "index_user_read_entries_on_entry_id", using: :btree
  add_index "user_read_entries", ["user_id", "entry_id"], name: "index_user_read_entries_on_user_id_and_entry_id", unique: true, using: :btree
  add_index "user_read_entries", ["user_id"], name: "index_user_read_entries_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                           null: false
    t.string   "email",                              null: false
    t.string   "password_digest",                    null: false
    t.string   "session_token",                      null: false
    t.boolean  "activated",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activation_token",                   null: false
    t.text     "description"
    t.string   "fname"
    t.string   "lname"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "reset_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
