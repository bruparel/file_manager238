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

ActiveRecord::Schema.define(:version => 20090519014326) do

  create_table "base_folders", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_comments", :force => true do |t|
    t.text     "content",    :default => ""
    t.integer  "client_id"
    t.integer  "user_id"
    t.boolean  "delta",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_comments", ["client_id"], :name => "index_client_comments_on_client_id"
  add_index "client_comments", ["delta"], :name => "index_client_comments_on_delta"
  add_index "client_comments", ["user_id"], :name => "index_client_comments_on_user_id"

  create_table "client_perms", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_perms", ["client_id"], :name => "index_client_perms_on_client_id"
  add_index "client_perms", ["user_id"], :name => "index_client_perms_on_user_id"

  create_table "client_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "client_name"
    t.string   "contact_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "mobile"
    t.string   "fax"
    t.text     "comment"
    t.integer  "client_status_id"
    t.boolean  "permit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["city"], :name => "index_clients_on_city"
  add_index "clients", ["client_name"], :name => "index_clients_on_client_name"
  add_index "clients", ["client_status_id"], :name => "index_clients_on_client_status_id"

  create_table "document_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.integer  "folder_id"
    t.integer  "document_status_id"
    t.string   "title"
    t.text     "description"
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["document_status_id"], :name => "index_documents_on_document_status_id"
  add_index "documents", ["folder_id"], :name => "index_documents_on_folder_id"

  create_table "folder_perms", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "folder_perms", ["client_id"], :name => "index_folder_perms_on_client_id"
  add_index "folder_perms", ["folder_id"], :name => "index_folder_perms_on_folder_id"
  add_index "folder_perms", ["user_id"], :name => "index_folder_perms_on_user_id"

  create_table "folders", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "client_id"
    t.boolean  "permit"
    t.boolean  "eclient_flag", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "folders", ["client_id"], :name => "index_folders_on_client_id"
  add_index "folders", ["parent_id"], :name => "index_folders_on_parent_id"

  create_table "roles", :force => true do |t|
    t.string "name"
    t.string "display_name"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "username",                                 :null => false
    t.string   "email",                                    :null => false
    t.string   "crypted_password",                         :null => false
    t.string   "password_salt",                            :null => false
    t.string   "persistence_token",                        :null => false
    t.integer  "login_count",       :default => 0,         :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "display_name"
    t.boolean  "active",            :default => true
    t.string   "theme",             :default => "default"
    t.text     "comment"
    t.integer  "role_id"
    t.integer  "client_id"
    t.boolean  "help_on",           :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["client_id"], :name => "index_users_on_client_id"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["username"], :name => "index_users_on_username"

end
