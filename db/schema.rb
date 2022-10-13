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

ActiveRecord::Schema.define(version: 2022_10_11_035119) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "checklists", force: :cascade do |t|
    t.integer "order_id"
    t.string "order_day"
    t.string "order_status"
    t.string "payment_type"
    t.string "payment_day"
    t.string "send_day"
    t.string "item_name"
    t.string "send_type"
    t.string "send_area"
    t.string "dead_line"
    t.integer "item_price"
    t.integer "quantity"
    t.integer "item_total_price"
    t.string "note"
    t.integer "total_price"
    t.integer "send_price"
    t.integer "all_total_price"
    t.string "user_id"
    t.string "nickname"
    t.string "use_name"
    t.string "user_tel"
    t.string "post_number"
    t.string "address1"
    t.string "address2"
    t.string "sending_name"
    t.string "sending_tel"
    t.string "item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.integer "suggestion_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["suggestion_id"], name: "index_comments_on_suggestion_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "confirms", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "suggestion_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "address"
    t.string "tel"
    t.string "receiver_name"
    t.string "postcode"
    t.index ["order_id"], name: "index_confirms_on_order_id"
    t.index ["suggestion_id"], name: "index_confirms_on_suggestion_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.integer "user_id", null: false
    t.integer "confirm_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirm_id"], name: "index_messages_on_confirm_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "order_tags", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id", "tag_id"], name: "index_order_tags_on_order_id_and_tag_id", unique: true
    t.index ["order_id"], name: "index_order_tags_on_order_id"
    t.index ["tag_id"], name: "index_order_tags_on_tag_id"
  end

  create_table "orders", force: :cascade do |t|
    t.text "title"
    t.text "body"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reciever"
    t.string "status", default: "pending"
    t.index ["user_id", "created_at"], name: "index_orders_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "suggestions", force: :cascade do |t|
    t.text "title"
    t.text "body"
    t.integer "order_id"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price", null: false
    t.integer "deadline", null: false
    t.index ["user_id"], name: "index_suggestions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.text "profile"
    t.string "address"
    t.string "tel"
    t.string "postcode"
    t.string "receiver_name"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "suggestions"
  add_foreign_key "comments", "users"
  add_foreign_key "confirms", "orders"
  add_foreign_key "confirms", "suggestions"
  add_foreign_key "messages", "confirms"
  add_foreign_key "messages", "users"
  add_foreign_key "order_tags", "orders"
  add_foreign_key "order_tags", "tags"
  add_foreign_key "orders", "users"
  add_foreign_key "suggestions", "users"
end
