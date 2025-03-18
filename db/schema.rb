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

ActiveRecord::Schema[8.0].define(version: 2025_03_18_180949) do
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "educations", force: :cascade do |t|
    t.integer "seller_profile_id", null: false
    t.string "degree"
    t.string "school_name"
    t.integer "graduation_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "new_column_name"
    t.index ["seller_profile_id"], name: "index_educations_on_seller_profile_id"
  end

  create_table "gigs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price"
    t.integer "seller_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "basic_price", default: "0.0", null: false
    t.decimal "standard_price", default: "0.0", null: false
    t.decimal "premium_price", default: "0.0", null: false
    t.text "basic_description"
    t.text "standard_description"
    t.text "premium_description"
    t.index ["seller_profile_id"], name: "index_gigs_on_seller_profile_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.text "message"
    t.string "price_range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["post_id"], name: "index_messages_on_post_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "user_id", null: false
    t.string "status"
    t.text "customer_message"
    t.text "creator_reply"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_orders_on_post_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "basic_price"
    t.decimal "standard_price"
    t.decimal "premium_price"
    t.integer "gig_id", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "seller_profiles", force: :cascade do |t|
    t.string "full_name"
    t.string "display_name"
    t.string "profile_picture"
    t.text "description"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "occupation"
    t.string "skills"
    t.string "education"
    t.string "certifications"
    t.string "personal_website"
    t.integer "start_year"
    t.integer "end_year"
    t.string "custom_occupation"
    t.string "skill_level"
    t.string "email"
    t.string "phone_number"
    t.integer "user_id"
    t.string "gig_title"
    t.text "gig_description"
    t.decimal "gig_price"
    t.string "country_code"
    t.string "website"
    t.string "country"
    t.index ["user_id"], name: "index_seller_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "educations", "seller_profiles"
  add_foreign_key "gigs", "seller_profiles"
  add_foreign_key "messages", "posts"
  add_foreign_key "messages", "users"
  add_foreign_key "orders", "posts"
  add_foreign_key "orders", "users"
  add_foreign_key "posts", "gigs"
  add_foreign_key "posts", "users"
end
