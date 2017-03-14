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

ActiveRecord::Schema.define(version: 20170314010509) do

  create_table "descendant_branches", force: :cascade do |t|
    t.integer  "parent_id",  null: false
    t.integer  "child_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "marriage_branches", force: :cascade do |t|
    t.integer  "husband_id",   null: false
    t.integer  "wife_id",      null: false
    t.date     "anniversary"
    t.date     "separated_on"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "memories", force: :cascade do |t|
    t.string   "title"
    t.string   "text_content"
    t.string   "audio_content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "moments", force: :cascade do |t|
    t.date     "when"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.date     "taken_on"
    t.date     "uploaded_on"
    t.string   "header"
    t.string   "caption"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "relatives", force: :cascade do |t|
    t.string   "first"
    t.string   "middle"
    t.string   "maiden"
    t.string   "surname"
    t.string   "nickname"
    t.string   "sex"
    t.date     "birthday"
    t.date     "deathday"
    t.string   "profile_image"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
