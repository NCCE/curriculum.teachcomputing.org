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

ActiveRecord::Schema[7.2].define(version: 2025_01_09_134130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "record_id", null: false
    t.string "record_type", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "aggregate_downloads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "downloadable_id", null: false
    t.string "downloadable_type", null: false
    t.integer "count", default: 0, null: false
    t.string "attachment_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "aggregate_ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "total_positive", default: 0, null: false
    t.integer "total_negative", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "rateable_id"
    t.string "rateable_type"
  end

  create_table "connected_world_strands", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "strand"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connected_world_strands_units", id: false, force: :cascade do |t|
    t.uuid "connected_world_strand_id", null: false
    t.uuid "unit_id", null: false
    t.index ["connected_world_strand_id"], name: "index_on_strand_id"
    t.index ["unit_id"], name: "index_strand_on_unit_id"
  end

  create_table "curriculum_maps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "key_stage_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key_stage_id"], name: "index_curriculum_maps_on_key_stage_id"
  end

  create_table "downloads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "aggregate_download_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_stem_achiever_contact_no"
    t.index ["aggregate_download_id"], name: "index_downloads_on_aggregate_download_id"
    t.index ["user_stem_achiever_contact_no"], name: "index_downloads_on_user_stem_achiever_contact_no"
  end

  create_table "file_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "context", null: false
    t.string "attachable_type", null: false
    t.uuid "attachable_id", null: false
    t.uuid "file_upload_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id", "file_upload_id"], name: "index_unique_attachable_and_file_upload", unique: true
    t.index ["attachable_type", "attachable_id"], name: "index_file_attachments_on_attachable"
    t.index ["file_upload_id"], name: "index_file_attachments_on_file_upload_id"
  end

  create_table "file_uploads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_file_uploads_on_slug", unique: true
  end

  create_table "key_stages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "level"
    t.string "ages"
    t.string "years"
    t.string "slug"
    t.string "title"
    t.index ["slug"], name: "index_key_stages_on_slug", unique: true
  end

  create_table "learning_objectives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "description", null: false
    t.uuid "lesson_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["lesson_id"], name: "index_learning_objectives_on_lesson_id"
  end

  create_table "learning_objectives_taxonomy_tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "taxonomy_tag_id", null: false
    t.uuid "learning_objective_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_objective_id"], name: "index_on_learning_objective_id"
    t.index ["taxonomy_tag_id"], name: "index_on_taxonomy_tag_id"
  end

  create_table "lessons", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.uuid "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.text "objectives"
    t.boolean "zip_synced", default: false
    t.datetime "zip_synced_at", precision: nil
    t.string "isaac_url"
    t.integer "order"
    t.integer "range"
    t.uuid "video_id"
    t.index ["slug", "unit_id"], name: "index_lessons_on_slug_and_unit_id", unique: true
    t.index ["unit_id"], name: "index_lessons_on_unit_id"
    t.index ["video_id"], name: "index_lessons_on_video_id"
  end

  create_table "national_curriculum_statements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "number"
    t.text "statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "national_curriculum_statements_units", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "national_curriculum_statement_id", null: false
    t.uuid "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["national_curriculum_statement_id"], name: "index_on_statement_id"
    t.index ["unit_id"], name: "index_on_unit_id"
  end

  create_table "ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "aggregate_rating_id", null: false
    t.boolean "positive", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_stem_achiever_contact_no"
    t.text "comment"
    t.string "choices", default: [], array: true
    t.index ["aggregate_rating_id"], name: "index_ratings_on_aggregate_rating_id"
    t.index ["user_stem_achiever_contact_no"], name: "index_ratings_on_user_stem_achiever_contact_no"
  end

  create_table "redirects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "redirectable_type", null: false
    t.uuid "redirectable_id", null: false
    t.string "from"
    t.string "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "from_context"
  end

  create_table "states", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "stateable_id"
    t.string "stateable_type"
  end

  create_table "success_criteria", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "description", null: false
    t.uuid "learning_objective_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["learning_objective_id"], name: "index_success_criteria_on_learning_objective_id"
  end

  create_table "taxonomy_tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "strand", null: false
    t.string "abbreviation", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.uuid "year_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "unit_documents_synced", default: false
    t.datetime "unit_documents_synced_at", precision: nil
    t.string "isaac_url"
    t.integer "order"
    t.boolean "display_i_belong_flag", default: false
    t.string "digital_summative_assessment_url"
    t.uuid "video_id"
    t.index ["video_id"], name: "index_units_on_video_id"
    t.index ["year_group_id"], name: "index_units_on_year_group_id"
  end

  create_table "url_links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "label", null: false
    t.string "url", null: false
    t.string "type_descriptor"
    t.uuid "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_url_links_on_unit_id"
  end

  create_table "videos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.string "name", null: false
    t.string "job_title", null: false
    t.text "description", null: false
    t.string "video_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "year_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "key_stage_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "year_number"
    t.string "slug"
    t.index ["key_stage_id"], name: "index_year_groups_on_key_stage_id"
    t.index ["slug"], name: "index_year_groups_on_slug", unique: true
  end

  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "connected_world_strands_units", "connected_world_strands"
  add_foreign_key "connected_world_strands_units", "units"
  add_foreign_key "downloads", "aggregate_downloads"
  add_foreign_key "file_attachments", "file_uploads"
  add_foreign_key "learning_objectives_taxonomy_tags", "learning_objectives"
  add_foreign_key "learning_objectives_taxonomy_tags", "taxonomy_tags"
  add_foreign_key "lessons", "videos"
  add_foreign_key "national_curriculum_statements_units", "national_curriculum_statements"
  add_foreign_key "national_curriculum_statements_units", "units"
  add_foreign_key "ratings", "aggregate_ratings"
  add_foreign_key "success_criteria", "learning_objectives"
  add_foreign_key "units", "videos"
  add_foreign_key "url_links", "units"
end
