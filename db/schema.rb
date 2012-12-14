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

ActiveRecord::Schema.define(:version => 20121214191409) do

  create_table "delayed_jobs", :force => true do |t|
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feedbacks", :force => true do |t|
    t.string   "topic"
    t.text     "plus"
    t.text     "delta"
    t.integer  "giver_id",      :null => false
    t.integer  "receiver_id",   :null => false
    t.string   "giver_type",    :null => false
    t.string   "receiver_type", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "request_id"
  end

  add_index "feedbacks", ["giver_id"], :name => "index_feedbacks_on_giver_id"
  add_index "feedbacks", ["giver_type"], :name => "index_feedbacks_on_giver_type"
  add_index "feedbacks", ["receiver_id"], :name => "index_feedbacks_on_receiver_id"
  add_index "feedbacks", ["receiver_type"], :name => "index_feedbacks_on_receiver_type"
  add_index "feedbacks", ["request_id"], :name => "index_feedbacks_on_request_id"

  create_table "guests", :force => true do |t|
    t.string   "email",                          :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "feedbacks_count", :default => 0, :null => false
  end

  create_table "history_events", :force => true do |t|
    t.string   "resource_type", :null => false
    t.integer  "resource_id",   :null => false
    t.integer  "owner_id",      :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "owner_type",    :null => false
  end

  create_table "invites", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id",    :null => false
    t.string   "email",      :null => false
    t.string   "token",      :null => false
  end

  create_table "requested_feedbacks", :force => true do |t|
    t.integer  "request_id", :null => false
    t.integer  "giver_id",   :null => false
    t.string   "giver_type", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "topic"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "email",                                                 :null => false
    t.string   "encrypted_password",  :limit => 128,                    :null => false
    t.string   "confirmation_token",  :limit => 128
    t.string   "remember_token",      :limit => 128,                    :null => false
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "username"
    t.integer  "remaining_invites",                  :default => 0,     :null => false
    t.integer  "invite_id"
    t.integer  "feedbacks_count",                    :default => 0,     :null => false
    t.integer  "requests_count",                     :default => 0,     :null => false
    t.integer  "invites_count",                      :default => 0,     :null => false
    t.boolean  "admin",                              :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "ventana_editable_contents", :force => true do |t|
    t.string   "key"
    t.text     "value"
    t.string   "content_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
