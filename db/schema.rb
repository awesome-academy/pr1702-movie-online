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

ActiveRecord::Schema.define(version: 20180516124501) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "film_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_comments_on_film_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.integer  "film_id"
    t.integer  "num_epi"
    t.string   "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_episodes_on_film_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "film_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_favourites_on_film_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "film_genres", force: :cascade do |t|
    t.integer  "film_id"
    t.integer  "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_film_genres_on_film_id"
    t.index ["genre_id"], name: "index_film_genres_on_genre_id"
  end

  create_table "film_origins", force: :cascade do |t|
    t.integer  "film_id"
    t.integer  "origin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_film_origins_on_film_id"
    t.index ["origin_id"], name: "index_film_origins_on_origin_id"
  end

  create_table "films", force: :cascade do |t|
    t.string   "name"
    t.string   "alter_name"
    t.integer  "copyright_year"
    t.text     "description"
    t.string   "img"
    t.integer  "category"
    t.integer  "num_view"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "film_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_histories_on_film_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "link_episodes", force: :cascade do |t|
    t.integer  "episode_id"
    t.string   "link"
    t.integer  "quality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_link_episodes_on_episode_id"
  end

  create_table "origins", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "film_id"
    t.integer  "star"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_ratings_on_film_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shares", force: :cascade do |t|
    t.integer  "shared_user_id"
    t.integer  "sharing_user_id"
    t.integer  "film_id"
    t.string   "message"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["film_id"], name: "index_shares_on_film_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
