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

ActiveRecord::Schema.define(:version => 20130924124514) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "image",       :default => "",   :null => false
    t.boolean  "available",   :default => true, :null => false
    t.integer  "client_id"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "customers", :force => true do |t|
    t.text     "name"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "phone",      :default => "", :null => false
    t.string   "email",      :default => "", :null => false
    t.string   "notes",      :default => "", :null => false
    t.integer  "client_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "icons", :force => true do |t|
    t.string   "name"
    t.string   "tags"
    t.string   "image"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "folder",     :default => "", :null => false
  end

  create_table "rentals", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "icon_id"
    t.integer  "depth",       :default => 1, :null => false
    t.integer  "category_id"
    t.integer  "available",   :default => 1, :null => false
    t.integer  "client_id"
  end

  create_table "reservations", :force => true do |t|
    t.integer  "rental_id"
    t.integer  "customer_id"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.integer  "state"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "payed",       :default => 0, :null => false
    t.integer  "delivered",   :default => 0, :null => false
    t.integer  "transferred", :default => 0, :null => false
    t.integer  "arrived",     :default => 0, :null => false
    t.float    "price"
    t.integer  "client_id"
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
    t.string   "section"
    t.string   "name"
    t.binary   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "client_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "name",          :default => "", :null => false
    t.integer  "client_id"
    t.string   "username",      :default => "", :null => false
    t.integer  "guest",         :default => 0,  :null => false
  end

end
