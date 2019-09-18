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

ActiveRecord::Schema.define(version: 20190918104341) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "composers", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "initial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorited_works", force: :cascade do |t|
    t.integer "favorite_id"
    t.integer "work_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
  end

  create_table "initials", force: :cascade do |t|
    t.string   "initial"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.string  "name"
    t.integer "category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

  create_table "works", force: :cascade do |t|
    t.string  "title"
    t.string  "image_url"
    t.string  "link_url"
    t.integer "composer_id"
    t.integer "subcategory_id"
  end

end
