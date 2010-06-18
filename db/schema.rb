# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100618085147) do

  create_table "annotations", :force => true do |t|
    t.integer  "loc_x",      :null => false
    t.integer  "loc_y",      :null => false
    t.integer  "screen_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentations", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", :force => true do |t|
    t.integer  "anno_id",    :null => false
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "screenshots", :force => true do |t|
    t.integer  "documentation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  add_index "screenshots", ["documentation_id"], :name => "index_screenshots_on_documentation_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
