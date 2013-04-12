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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130412080011) do

  create_table "customers", :force => true do |t|
    t.text     "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "icons", :force => true do |t|
    t.string   "name"
    t.string   "tags"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rentals", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "group_id"
    t.integer  "icon_id"
    t.string   "category"
  end

  create_table "reservations", :force => true do |t|
    t.integer  "rental_id"
    t.integer  "customer_id"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.integer  "state"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "group_id"
  end

  create_table "scenes", :force => true do |t|
    t.string   "name"
    t.binary   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "scenes", ["user_id"], :name => "index_scenes_on_user_id"

  create_table "sessions", :force => true do |t|
    t.integer  "user_id"
    t.string   "sid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["sid"], :name => "index_sessions_on_sid"
  add_index "sessions", ["user_id"], :name => "index_sessions_on_user_id"

  create_table "settings", :force => true do |t|
    t.integer  "group_id"
    t.string   "section"
    t.string   "name"
    t.binary   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "group_id"
  end

end
