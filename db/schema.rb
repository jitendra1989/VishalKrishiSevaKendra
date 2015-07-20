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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150720071026) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "ancestry",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.integer  "mobile",          limit: 8
    t.integer  "phone",           limit: 8
    t.string   "address",         limit: 255
    t.integer  "pincode",         limit: 4
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.string   "country",         limit: 255
    t.string   "company_name",    limit: 255
    t.string   "company_address", limit: 255
    t.integer  "company_phone",   limit: 8
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "outlets", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "country",    limit: 255
    t.string   "state",      limit: 255
    t.string   "city",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "subject_class", limit: 255
    t.integer  "subject_id",    limit: 4
    t.string   "action",        limit: 255
    t.text     "description",   limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "product_categories", ["category_id"], name: "index_product_categories_on_category_id", using: :btree
  add_index "product_categories", ["product_id"], name: "index_product_categories_on_product_id", using: :btree

  create_table "product_images", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "product_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "product_images", ["product_id"], name: "index_product_images_on_product_id", using: :btree

  create_table "product_type_taxes", force: :cascade do |t|
    t.integer  "product_type_id", limit: 4
    t.integer  "tax_id",          limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "product_type_taxes", ["product_type_id"], name: "index_product_type_taxes_on_product_type_id", using: :btree
  add_index "product_type_taxes", ["tax_id"], name: "index_product_type_taxes_on_tax_id", using: :btree

  create_table "product_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "code",            limit: 255
    t.text     "description",     limit: 65535
    t.decimal  "price",                         precision: 10, scale: 2
    t.integer  "product_type_id", limit: 4
    t.boolean  "active",          limit: 1,                              default: false, null: false
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
  end

  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree

  create_table "quotation_products", force: :cascade do |t|
    t.integer  "quotation_id", limit: 4
    t.integer  "product_id",   limit: 4
    t.string   "name",         limit: 255
    t.integer  "quantity",     limit: 4
    t.decimal  "price",                    precision: 10, scale: 2
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "quotation_products", ["product_id"], name: "index_quotation_products_on_product_id", using: :btree
  add_index "quotation_products", ["quotation_id"], name: "index_quotation_products_on_quotation_id", using: :btree

  create_table "quotations", force: :cascade do |t|
    t.integer  "customer_id",     limit: 4
    t.integer  "user_id",         limit: 4
    t.decimal  "discount_amount",           precision: 10, scale: 2
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "quotations", ["customer_id"], name: "index_quotations_on_customer_id", using: :btree
  add_index "quotations", ["user_id"], name: "index_quotations_on_user_id", using: :btree

  create_table "role_permissions", force: :cascade do |t|
    t.integer  "role_id",       limit: 4
    t.integer  "permission_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "role_permissions", ["permission_id"], name: "index_role_permissions_on_permission_id", using: :btree
  add_index "role_permissions", ["role_id"], name: "index_role_permissions_on_role_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "taxes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.float    "percentage", limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_permissions", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "permission_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "user_permissions", ["permission_id"], name: "index_user_permissions_on_permission_id", using: :btree
  add_index "user_permissions", ["user_id"], name: "index_user_permissions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "username",        limit: 255
    t.string   "password_digest", limit: 255
    t.string   "email",           limit: 255
    t.integer  "phone",           limit: 8
    t.string   "address",         limit: 255
    t.integer  "pincode",         limit: 4
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.string   "country",         limit: 255
    t.integer  "outlet_id",       limit: 4
    t.string   "role",            limit: 255
    t.boolean  "active",          limit: 1,   default: false, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "users", ["outlet_id"], name: "index_users_on_outlet_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "product_categories", "categories"
  add_foreign_key "product_categories", "products"
  add_foreign_key "product_images", "products"
  add_foreign_key "product_type_taxes", "product_types"
  add_foreign_key "product_type_taxes", "taxes"
  add_foreign_key "products", "product_types"
  add_foreign_key "quotation_products", "products"
  add_foreign_key "quotation_products", "quotations"
  add_foreign_key "quotations", "customers"
  add_foreign_key "quotations", "users"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "user_permissions", "permissions"
  add_foreign_key "user_permissions", "users"
  add_foreign_key "users", "outlets"
end
