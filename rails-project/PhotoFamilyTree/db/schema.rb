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

ActiveRecord::Schema.define(version: 20170423083150) do

  create_table "descendant_branches", force: :cascade do |t|
    t.integer  "parent_id",   null: false
    t.integer  "child_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "parent_type"
  end

  create_table "event_tags", force: :cascade do |t|
    t.integer  "event_id",    null: false
    t.integer  "relative_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["event_id"], name: "index_event_tags_on_event_id"
    t.index ["relative_id"], name: "index_event_tags_on_relative_id"
  end

  create_table "events", force: :cascade do |t|
    t.date     "when"
    t.string   "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "location"
    t.string   "event_type"
    t.integer  "event_owner_id"
  end

  create_table "marriage_branches", force: :cascade do |t|
    t.integer  "husband_id",   null: false
    t.integer  "wife_id",      null: false
    t.date     "anniversary"
    t.date     "marriage_end"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "memories", force: :cascade do |t|
    t.string   "title"
    t.string   "text_content"
    t.string   "audio_content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "location"
    t.integer  "poster_id"
    t.date     "when"
    t.index ["poster_id"], name: "index_memories_on_poster_id"
  end

  create_table "photo_tags", force: :cascade do |t|
    t.integer  "photo_id",    null: false
    t.integer  "relative_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["photo_id"], name: "index_photo_tags_on_photo_id"
    t.index ["relative_id"], name: "index_photo_tags_on_relative_id"
  end

  create_table "photos", force: :cascade do |t|
    t.date     "taken_on"
    t.string   "header"
    t.string   "caption"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "photograph"
    t.string   "location"
    t.integer  "poster_id"
    t.integer  "photo_width"
    t.integer  "photo_height"
    t.index ["poster_id"], name: "index_photos_on_poster_id"
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
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "profile_photo"
    t.string   "suffix"
    t.integer  "photo_width"
    t.integer  "photo_height"
  end

end
