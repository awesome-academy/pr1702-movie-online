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

ActiveRecord::Schema.define(version: 20180626155708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id"
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "film_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_comments_on_film_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "episodes", force: :cascade do |t|
    t.integer  "film_id"
    t.integer  "num_epi"
    t.string   "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_episodes_on_film_id", using: :btree
  end

  create_table "favourites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "film_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_favourites_on_film_id", using: :btree
    t.index ["user_id"], name: "index_favourites_on_user_id", using: :btree
  end

  create_table "film_genres", force: :cascade do |t|
    t.integer  "film_id"
    t.integer  "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_film_genres_on_film_id", using: :btree
    t.index ["genre_id"], name: "index_film_genres_on_genre_id", using: :btree
  end

  create_table "film_origins", force: :cascade do |t|
    t.integer  "film_id"
    t.integer  "origin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id"], name: "index_film_origins_on_film_id", using: :btree
    t.index ["origin_id"], name: "index_film_origins_on_origin_id", using: :btree
  end

  create_table "films", force: :cascade do |t|
    t.string   "name"
    t.string   "alter_name"
    t.integer  "copyright_year"
    t.text     "description"
    t.string   "img"
    t.integer  "num_ep"
    t.integer  "num_view"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "comment_count"
    t.float    "rate_point"
    t.integer  "released_episodes_status"
    t.string   "slug"
    t.index ["slug"], name: "index_films_on_slug", unique: true, using: :btree
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
    t.index ["film_id"], name: "index_histories_on_film_id", using: :btree
    t.index ["user_id"], name: "index_histories_on_user_id", using: :btree
  end

  create_table "link_episodes", force: :cascade do |t|
    t.integer  "episode_id"
    t.string   "link",       limit: 5000
    t.integer  "quality"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["episode_id"], name: "index_link_episodes_on_episode_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "src_id"
    t.string   "src_type"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "origins", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "overall_averages", force: :cascade do |t|
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id"
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
    t.index ["rater_id"], name: "index_rates_on_rater_id", using: :btree
  end

  create_table "rating_caches", force: :cascade do |t|
    t.string   "cacheable_type"
    t.integer  "cacheable_id"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "requesting_id"
    t.integer  "requested_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "status"
    t.index ["requested_id"], name: "index_relationships_on_requested_id", using: :btree
    t.index ["requesting_id", "requested_id"], name: "index_relationships_on_requesting_id_and_requested_id", unique: true, using: :btree
    t.index ["requesting_id"], name: "index_relationships_on_requesting_id", using: :btree
  end

  create_table "shares", force: :cascade do |t|
    t.integer  "shared_user_id"
    t.integer  "sharing_user_id"
    t.integer  "film_id"
    t.string   "message"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["film_id"], name: "index_shares_on_film_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "role"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "comments", "films"
  add_foreign_key "comments", "users"
  add_foreign_key "episodes", "films"
  add_foreign_key "favourites", "films"
  add_foreign_key "favourites", "users"
  add_foreign_key "film_genres", "films"
  add_foreign_key "film_genres", "genres"
  add_foreign_key "film_origins", "films"
  add_foreign_key "film_origins", "origins"
  add_foreign_key "histories", "films"
  add_foreign_key "histories", "users"
  add_foreign_key "link_episodes", "episodes"
  add_foreign_key "notifications", "users"
  add_foreign_key "shares", "films"
end
