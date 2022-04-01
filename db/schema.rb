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

ActiveRecord::Schema.define(version: 2022_04_01_045024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "data_models", force: :cascade do |t|
    t.bigint "created_by_id"
    t.bigint "office_id"
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_data_models_on_created_by_id"
    t.index ["office_id"], name: "index_data_models_on_office_id"
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "created_by_id"
    t.bigint "template_id"
    t.bigint "instance_id"
    t.string "version"
    t.string "name"
    t.text "context"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_documents_on_created_by_id"
    t.index ["instance_id"], name: "index_documents_on_instance_id"
    t.index ["template_id"], name: "index_documents_on_template_id"
  end

  create_table "instance_properties", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "value"
    t.bigint "instance_id", null: false
    t.bigint "model_property_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "required", default: false
    t.integer "position", default: 0
    t.text "default_value"
    t.index ["instance_id"], name: "index_instance_properties_on_instance_id"
    t.index ["model_property_id"], name: "index_instance_properties_on_model_property_id"
  end

  create_table "instances", force: :cascade do |t|
    t.bigint "created_by_id"
    t.bigint "data_model_id"
    t.string "data_model_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_by_id"], name: "index_instances_on_created_by_id"
    t.index ["data_model_id"], name: "index_instances_on_data_model_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "office_id"
    t.bigint "user_id"
    t.datetime "invited_at"
    t.integer "member_status", default: 1
    t.integer "member_role", default: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["office_id"], name: "index_members_on_office_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "model_properties", force: :cascade do |t|
    t.bigint "data_model_id"
    t.text "name"
    t.text "default_value"
    t.integer "property_type", default: 0
    t.boolean "required", default: false
    t.string "code"
    t.text "description"
    t.boolean "header_visibility"
    t.integer "position", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data_model_id"], name: "index_model_properties_on_data_model_id"
  end

  create_table "offices", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "created_by_id", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "thumbnail_color"
    t.index ["created_by_id"], name: "index_offices_on_created_by_id"
    t.index ["slug"], name: "index_offices_on_slug", unique: true
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.bigint "office_id"
    t.text "description"
    t.bigint "data_model_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data_model_id"], name: "index_templates_on_data_model_id"
    t.index ["office_id"], name: "index_templates_on_office_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
