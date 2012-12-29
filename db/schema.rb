# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121229171645) do

  create_table "appointments", :force => true do |t|
    t.integer  "meeting_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "message"
    t.boolean  "accept",       :default => false
    t.boolean  "reject",       :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "meetings", :force => true do |t|
    t.integer  "user_id"
    t.date     "date",                              :null => false
    t.string   "location"
    t.string   "address",                           :null => false
    t.text     "message"
    t.string   "teach_language",                    :null => false
    t.string   "study_language",                    :null => false
    t.boolean  "success",        :default => false, :null => false
    t.boolean  "close",          :default => false, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "start_hour",     :default => "00",  :null => false
    t.string   "start_minute",   :default => "00",  :null => false
    t.string   "end_hour",       :default => "00",  :null => false
    t.string   "end_minute",     :default => "00",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "native_language",  :default => "ja", :null => false
    t.string   "learn_language",   :default => "ja", :null => false
    t.text     "message"
    t.string   "email"
    t.boolean  "getting_started",  :default => true, :null => false
    t.string   "profile_url"
  end

end
