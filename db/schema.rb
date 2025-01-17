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

ActiveRecord::Schema[7.1].define(version: 2024_10_10_072630) do
  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "google_accounts", force: :cascade do |t|
    t.string "email"
    t.string "image"
    t.string "token"
    t.string "refresh"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_google_accounts_on_user_id"
  end

  create_table "itemcomments", force: :cascade do |t|
    t.string "post_body"
    t.integer "user_id", null: false
    t.integer "itempost_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["itempost_id"], name: "index_itemcomments_on_itempost_id"
    t.index ["user_id"], name: "index_itemcomments_on_user_id"
  end

  create_table "itemposts", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["user_id"], name: "index_itemposts_on_user_id"
  end

  create_table "textposts", force: :cascade do |t|
    t.string "post_title"
    t.string "post_body"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["user_id"], name: "index_textposts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
  end

  add_foreign_key "google_accounts", "users"
  add_foreign_key "itemcomments", "itemposts"
  add_foreign_key "itemcomments", "users"
  add_foreign_key "itemposts", "users"
  add_foreign_key "textposts", "users"
end
