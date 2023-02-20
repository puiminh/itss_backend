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

ActiveRecord::Schema[7.0].define(version: 2023_02_20_051411) do
  create_table "bookmark_collections", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "collection_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_bookmark_collections_on_collection_id"
    t.index ["user_id", "collection_id"], name: "index_bookmark_collections_on_user_id_and_collection_id", unique: true
    t.index ["user_id"], name: "index_bookmark_collections_on_user_id"
  end

  create_table "bookmark_courses", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_bookmark_courses_on_course_id"
    t.index ["user_id", "course_id"], name: "index_bookmark_courses_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_bookmark_courses_on_user_id"
  end

  create_table "collections", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image"
    t.bigint "author_id"
    t.index ["author_id"], name: "index_collections_on_author_id"
  end

  create_table "collections_courses", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "collection_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id", "course_id"], name: "index_collections_courses_on_collection_id_and_course_id", unique: true
    t.index ["collection_id"], name: "index_collections_courses_on_collection_id"
    t.index ["course_id"], name: "index_collections_courses_on_course_id"
  end

  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_comments_on_course_id"
    t.index ["user_id", "course_id"], name: "index_comments_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "courses", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id"
    t.index ["author_id"], name: "index_courses_on_author_id"
  end

  create_table "notices", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "action"
    t.string "data"
    t.integer "seen"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "from"
    t.index ["from"], name: "fk_rails_113fde3206"
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "progresses", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "point"
    t.bigint "user_id"
    t.bigint "course_id"
    t.bigint "vocabulary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_progresses_on_course_id"
    t.index ["user_id", "course_id", "vocabulary_id"], name: "index_progresses_on_user_id_and_course_id_and_vocabulary_id", unique: true
    t.index ["user_id"], name: "index_progresses_on_user_id"
    t.index ["vocabulary_id"], name: "index_progresses_on_vocabulary_id"
  end

  create_table "ratings", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "star"
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_ratings_on_course_id"
    t.index ["user_id", "course_id"], name: "index_ratings_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "user_name"
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vocabularies", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "word"
    t.text "define"
    t.text "link"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_id"
    t.index ["course_id"], name: "index_vocabularies_on_course_id"
  end

  add_foreign_key "collections", "users", column: "author_id"
  add_foreign_key "courses", "users", column: "author_id"
  add_foreign_key "notices", "users"
  add_foreign_key "notices", "users", column: "from"
  add_foreign_key "vocabularies", "courses"
end
