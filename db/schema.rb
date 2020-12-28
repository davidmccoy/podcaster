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

ActiveRecord::Schema.define(version: 2020_12_28_164124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "category_pages", force: :cascade do |t|
    t.bigint "page_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_category_pages_on_category_id"
    t.index ["page_id"], name: "index_category_pages_on_page_id"
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
    t.boolean "externally_hosted", default: false
    t.text "external_rss"
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
    t.bigint "total_downloads", default: 0
    t.bigint "individual_downloads", default: 0
    t.bigint "aggregate_feed_downloads", default: 0
    t.boolean "imported", default: false
    t.text "guid"
    t.text "import_errors"
    t.index ["file_migrated"], name: "index_podcast_episodes_on_file_migrated"
    t.index ["guid"], name: "index_podcast_episodes_on_guid"
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
    t.boolean "multiple_podcasts", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
