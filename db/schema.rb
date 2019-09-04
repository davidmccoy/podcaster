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

ActiveRecord::Schema.define(version: 2019_09_04_001653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "type", null: false
    t.string "attachable_type"
    t.bigint "attachable_id"
    t.text "file_data"
    t.integer "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable_type_and_attachable_id"
    t.index ["label"], name: "index_attachments_on_label"
  end

  create_table "episodes", force: :cascade do |t|
    t.integer "podcast_id"
    t.string "blubrry_filename"
    t.string "blubrry_file_url"
    t.string "blubrry_date"
    t.integer "blubrry_unique_downloads"
    t.integer "blubrry_total_downloads"
    t.string "title"
    t.string "artist"
    t.datetime "date"
    t.boolean "file_migrated", default: false
    t.text "description"
    t.index ["blubrry_filename"], name: "index_episodes_on_blubrry_filename"
    t.index ["date"], name: "index_episodes_on_date"
    t.index ["file_migrated"], name: "index_episodes_on_file_migrated"
    t.index ["podcast_id"], name: "index_episodes_on_podcast_id"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "included_in_aggregate_feed", default: false
    t.index ["included_in_aggregate_feed"], name: "index_pages_on_included_in_aggregate_feed"
    t.index ["slug"], name: "index_pages_on_slug"
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "podcast_episodes", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "filename"
    t.string "external_file_url"
    t.string "external_date"
    t.integer "external_unique_downloads"
    t.integer "external_total_downloads"
    t.datetime "date"
    t.boolean "file_migrated", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["file_migrated"], name: "index_podcast_episodes_on_file_migrated"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "page_id"
    t.string "postable_type"
    t.bigint "postable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "publish_time"
    t.string "slug"
    t.index ["page_id"], name: "index_posts_on_page_id"
    t.index ["postable_type", "postable_id"], name: "index_posts_on_postable_type_and_postable_id"
    t.index ["slug"], name: "index_posts_on_slug"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
