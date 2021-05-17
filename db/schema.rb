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

ActiveRecord::Schema.define(version: 2021_05_17_134927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "record_id", null: false
    t.string "record_type", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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

  create_table "aggregate_downloads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "downloadable_id", null: false
    t.string "downloadable_type", null: false
    t.integer "count", default: 0, null: false
    t.string "attachment_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "aggregate_ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "total_positive", default: 0, null: false
    t.integer "total_negative", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "rateable_id"
    t.string "rateable_type"
  end

  create_table "curriculum_maps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "key_stage_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key_stage_id"], name: "index_curriculum_map_on_key_stage_id"
  end

  create_table "downloads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "aggregate_download_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_stem_achiever_contact_no"
    t.index ["aggregate_download_id"], name: "index_downloads_on_aggregate_download_id"
    t.index ["user_stem_achiever_contact_no"], name: "index_downloads_on_user_stem_achiever_contact_no"
  end

  create_table "key_stages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "level"
    t.string "ages"
    t.string "years"
    t.string "slug"
    t.index ["slug"], name: "index_key_stages_on_slug", unique: true
  end

  create_table "lessons", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.uuid "unit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.text "objectives"
    t.boolean "zip_synced", default: false
    t.datetime "zip_synced_at"
    t.integer "lesson_no", default: 0
    t.index ["slug", "unit_id"], name: "index_lessons_on_slug_and_unit_id", unique: true
    t.index ["unit_id"], name: "index_lessons_on_unit_id"
  end

  create_table "ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "aggregate_rating_id", null: false
    t.boolean "positive", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "user_stem_achiever_contact_no"
    t.text "comment"
    t.index ["aggregate_rating_id"], name: "index_ratings_on_aggregate_rating_id"
    t.index ["user_stem_achiever_contact_no"], name: "index_ratings_on_user_stem_achiever_contact_no"
  end

  create_table "states", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "state", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "stateable_id"
    t.string "stateable_type"
  end

  create_table "units", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.uuid "year_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.boolean "unit_documents_synced", default: false
    t.datetime "unit_documents_synced_at"
    t.index ["slug"], name: "index_units_on_slug", unique: true
    t.index ["year_group_id"], name: "index_units_on_year_group_id"
  end

  create_table "year_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "key_stage_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "year_number"
    t.string "slug"
    t.index ["key_stage_id"], name: "index_year_groups_on_key_stage_id"
    t.index ["slug"], name: "index_year_groups_on_slug", unique: true
  end

  add_foreign_key "downloads", "aggregate_downloads"
  add_foreign_key "ratings", "aggregate_ratings"
end
