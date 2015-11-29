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

ActiveRecord::Schema.define(version: 20151129151336) do

  create_table "banner_categories", force: :cascade do |t|
    t.integer  "banner_id",   limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "banner_categories", ["banner_id"], name: "index_banner_categories_on_banner_id", using: :btree
  add_index "banner_categories", ["category_id"], name: "index_banner_categories_on_category_id", using: :btree

  create_table "banners", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "image",      limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "cart_item_customisations", force: :cascade do |t|
    t.integer  "cart_item_id",     limit: 4
    t.integer  "specification_id", limit: 4
    t.string   "value",            limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "cart_item_customisations", ["cart_item_id"], name: "index_cart_item_customisations_on_cart_item_id", using: :btree
  add_index "cart_item_customisations", ["specification_id"], name: "index_cart_item_customisations_on_specification_id", using: :btree

  create_table "cart_item_image_customisations", force: :cascade do |t|
    t.integer  "cart_item_id",            limit: 4
    t.integer  "characteristic_id",       limit: 4
    t.integer  "characteristic_image_id", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "cart_item_image_customisations", ["cart_item_id"], name: "index_cart_item_image_customisations_on_cart_item_id", using: :btree
  add_index "cart_item_image_customisations", ["characteristic_id"], name: "index_cart_item_image_customisations_on_characteristic_id", using: :btree
  add_index "cart_item_image_customisations", ["characteristic_image_id"], name: "index_cart_item_image_customisations_on_characteristic_image_id", using: :btree

  create_table "cart_items", force: :cascade do |t|
    t.integer  "product_id",                 limit: 4
    t.integer  "cart_id",                    limit: 4
    t.integer  "quantity",                   limit: 4, default: 0, null: false
    t.integer  "customisations_count",       limit: 4, default: 0, null: false
    t.integer  "image_customisations_count", limit: 4, default: 0, null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.integer  "customer_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "outlet_id",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "carts", ["customer_id"], name: "index_carts_on_customer_id", using: :btree
  add_index "carts", ["outlet_id", "customer_id"], name: "index_carts_on_outlet_id_and_customer_id", unique: true, using: :btree
  add_index "carts", ["outlet_id"], name: "index_carts_on_outlet_id", using: :btree
  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "ancestry",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "slug",       limit: 255
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry", using: :btree
  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "category_coupons", force: :cascade do |t|
    t.integer  "category_id",    limit: 4
    t.integer  "coupon_code_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "category_coupons", ["category_id"], name: "index_category_coupons_on_category_id", using: :btree
  add_index "category_coupons", ["coupon_code_id"], name: "index_category_coupons_on_coupon_code_id", using: :btree

  create_table "characteristic_images", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "characteristic_id", limit: 4
    t.string   "code",              limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "characteristic_images", ["characteristic_id"], name: "index_characteristic_images_on_characteristic_id", using: :btree

  create_table "characteristics", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "content_pages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "image",      limit: 255
    t.text     "content",    limit: 65535
    t.boolean  "menu",       limit: 1,     default: false, null: false
    t.string   "link_text",  limit: 255
    t.string   "slug",       limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "coupon_codes", force: :cascade do |t|
    t.string   "code",        limit: 255
    t.decimal  "percent",                 precision: 10, scale: 2
    t.boolean  "active",      limit: 1,                            default: false, null: false
    t.datetime "active_from"
    t.datetime "active_to"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "password_digest",        limit: 255
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "email",                  limit: 255
    t.integer  "mobile",                 limit: 8
    t.integer  "phone",                  limit: 8
    t.string   "address",                limit: 255
    t.integer  "pincode",                limit: 4
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "country",                limit: 255
    t.integer  "orders_count",           limit: 4,   default: 0,     null: false
    t.string   "company_name",           limit: 255
    t.string   "company_address",        limit: 255
    t.integer  "company_phone",          limit: 8
    t.string   "activation_digest",      limit: 255
    t.boolean  "activated",              limit: 1,   default: false, null: false
    t.datetime "activated_at"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.datetime "deleted_at"
  end

  add_index "customers", ["deleted_at"], name: "index_customers_on_deleted_at", using: :btree

  create_table "group_items", force: :cascade do |t|
    t.integer  "product_id",         limit: 4
    t.integer  "related_product_id", limit: 4
    t.integer  "quantity",           limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "group_items", ["product_id"], name: "index_group_items_on_product_id", using: :btree
  add_index "group_items", ["related_product_id"], name: "index_group_items_on_related_product_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.decimal  "amount",                precision: 10, scale: 2
    t.integer  "customer_id", limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "invoices", ["customer_id"], name: "index_invoices_on_customer_id", using: :btree

  create_table "online_cart_items", force: :cascade do |t|
    t.integer  "product_id",     limit: 4
    t.integer  "online_cart_id", limit: 4
    t.integer  "quantity",       limit: 4, default: 0, null: false
    t.integer  "integer",        limit: 4, default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "online_cart_items", ["online_cart_id"], name: "index_online_cart_items_on_online_cart_id", using: :btree
  add_index "online_cart_items", ["product_id"], name: "index_online_cart_items_on_product_id", using: :btree

  create_table "online_carts", force: :cascade do |t|
    t.integer  "customer_id",    limit: 4
    t.integer  "coupon_code_id", limit: 4
    t.datetime "blocked_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "online_carts", ["coupon_code_id"], name: "index_online_carts_on_coupon_code_id", using: :btree
  add_index "online_carts", ["customer_id"], name: "index_online_carts_on_customer_id", using: :btree

  create_table "online_order_items", force: :cascade do |t|
    t.integer  "online_order_id", limit: 4
    t.integer  "product_id",      limit: 4
    t.string   "name",            limit: 255
    t.integer  "quantity",        limit: 4
    t.decimal  "price",                       precision: 10, scale: 2
    t.decimal  "discount_amount",             precision: 10, scale: 2, default: 0.0, null: false
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
  end

  add_index "online_order_items", ["online_order_id"], name: "index_online_order_items_on_online_order_id", using: :btree
  add_index "online_order_items", ["product_id"], name: "index_online_order_items_on_product_id", using: :btree

  create_table "online_order_taxes", force: :cascade do |t|
    t.integer  "online_order_id", limit: 4
    t.string   "name",            limit: 255
    t.float    "percentage",      limit: 24,                           default: 0.0, null: false
    t.decimal  "amount",                      precision: 10, scale: 2, default: 0.0, null: false
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
  end

  add_index "online_order_taxes", ["online_order_id"], name: "index_online_order_taxes_on_online_order_id", using: :btree

  create_table "online_orders", force: :cascade do |t|
    t.integer  "customer_id",    limit: 4
    t.decimal  "subtotal",                     precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "tax_amount",                   precision: 10, scale: 2, default: 0.0, null: false
    t.integer  "coupon_code_id", limit: 4
    t.text     "payment_info",   limit: 65535
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
  end

  add_index "online_orders", ["coupon_code_id"], name: "index_online_orders_on_coupon_code_id", using: :btree
  add_index "online_orders", ["customer_id"], name: "index_online_orders_on_customer_id", using: :btree

  create_table "online_taxes", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.float    "percentage",    limit: 24,  default: 0.0,  null: false
    t.string   "ancestry",      limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "fully_taxable", limit: 1,   default: true, null: false
  end

  add_index "online_taxes", ["ancestry"], name: "index_online_taxes_on_ancestry", using: :btree

  create_table "order_item_customisations", force: :cascade do |t|
    t.integer  "order_item_id",    limit: 4
    t.integer  "specification_id", limit: 4
    t.string   "value",            limit: 255
    t.integer  "user_id",          limit: 4
    t.integer  "status",           limit: 4,   default: 0, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "order_item_customisations", ["order_item_id"], name: "index_order_item_customisations_on_order_item_id", using: :btree
  add_index "order_item_customisations", ["specification_id"], name: "index_order_item_customisations_on_specification_id", using: :btree
  add_index "order_item_customisations", ["user_id"], name: "index_order_item_customisations_on_user_id", using: :btree

  create_table "order_item_image_customisations", force: :cascade do |t|
    t.integer  "order_item_id",           limit: 4
    t.integer  "characteristic_id",       limit: 4
    t.integer  "characteristic_image_id", limit: 4
    t.integer  "user_id",                 limit: 4
    t.integer  "status",                  limit: 4, default: 0, null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "order_item_image_customisations", ["characteristic_id"], name: "index_order_item_image_customisations_on_characteristic_id", using: :btree
  add_index "order_item_image_customisations", ["characteristic_image_id"], name: "index_order_item_image_customisations_on_characteristic_image_id", using: :btree
  add_index "order_item_image_customisations", ["order_item_id"], name: "index_order_item_image_customisations_on_order_item_id", using: :btree
  add_index "order_item_image_customisations", ["user_id"], name: "index_order_item_image_customisations_on_user_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id",                   limit: 4
    t.integer  "product_id",                 limit: 4
    t.string   "name",                       limit: 255
    t.integer  "quantity",                   limit: 4
    t.decimal  "price",                                  precision: 10, scale: 2
    t.integer  "customisations_count",       limit: 4,                            default: 0, null: false
    t.integer  "image_customisations_count", limit: 4,                            default: 0, null: false
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "order_taxes", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.string   "name",       limit: 255
    t.decimal  "amount",                 precision: 10, scale: 2, default: 0.0, null: false
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  add_index "order_taxes", ["order_id"], name: "index_order_taxes_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "customer_id",     limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "outlet_id",       limit: 4
    t.decimal  "subtotal",                      precision: 10, scale: 2, default: 0.0,   null: false
    t.decimal  "tax_amount",                    precision: 10, scale: 2, default: 0.0,   null: false
    t.decimal  "discount_amount",               precision: 10, scale: 2, default: 0.0,   null: false
    t.integer  "receipts_count",  limit: 4,                              default: 0,     null: false
    t.boolean  "overridden",      limit: 1,                              default: false, null: false
    t.text     "details",         limit: 65535
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.integer  "invoice_id",      limit: 4
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  add_index "orders", ["invoice_id"], name: "index_orders_on_invoice_id", using: :btree
  add_index "orders", ["outlet_id"], name: "index_orders_on_outlet_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "outlets", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "country",      limit: 255
    t.string   "state",        limit: 255
    t.string   "city",         limit: 255
    t.boolean  "online_store", limit: 1,   default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.datetime "deleted_at"
  end

  add_index "outlets", ["deleted_at"], name: "index_outlets_on_deleted_at", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "action",      limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "product_categories", ["category_id"], name: "index_product_categories_on_category_id", using: :btree
  add_index "product_categories", ["product_id"], name: "index_product_categories_on_product_id", using: :btree

  create_table "product_characteristics", force: :cascade do |t|
    t.integer  "product_id",              limit: 4
    t.integer  "characteristic_id",       limit: 4
    t.integer  "characteristic_image_id", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "product_characteristics", ["characteristic_id"], name: "index_product_characteristics_on_characteristic_id", using: :btree
  add_index "product_characteristics", ["characteristic_image_id"], name: "index_product_characteristics_on_characteristic_image_id", using: :btree
  add_index "product_characteristics", ["product_id", "characteristic_id"], name: "product_characteristic", unique: true, using: :btree
  add_index "product_characteristics", ["product_id"], name: "index_product_characteristics_on_product_id", using: :btree

  create_table "product_coupons", force: :cascade do |t|
    t.integer  "product_id",     limit: 4
    t.integer  "coupon_code_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "product_coupons", ["coupon_code_id"], name: "index_product_coupons_on_coupon_code_id", using: :btree
  add_index "product_coupons", ["product_id"], name: "index_product_coupons_on_product_id", using: :btree

  create_table "product_images", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "product_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "product_images", ["product_id"], name: "index_product_images_on_product_id", using: :btree

  create_table "product_specifications", force: :cascade do |t|
    t.integer  "product_id",       limit: 4
    t.integer  "specification_id", limit: 4
    t.string   "value",            limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "product_specifications", ["product_id"], name: "index_product_specifications_on_product_id", using: :btree
  add_index "product_specifications", ["specification_id"], name: "index_product_specifications_on_specification_id", using: :btree

  create_table "product_type_taxes", force: :cascade do |t|
    t.integer  "product_type_id", limit: 4
    t.integer  "tax_id",          limit: 4
    t.string   "ancestry",        limit: 255
    t.boolean  "fully_taxable",   limit: 1,   default: true, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "product_type_taxes", ["product_type_id"], name: "index_product_type_taxes_on_product_type_id", using: :btree
  add_index "product_type_taxes", ["tax_id"], name: "index_product_type_taxes_on_tax_id", using: :btree

  create_table "product_types", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.boolean  "require_workshop", limit: 1,   default: false, null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "slug",            limit: 255
    t.string   "code",            limit: 255
    t.text     "description",     limit: 65535
    t.decimal  "price",                         precision: 10, scale: 2
    t.decimal  "sale_price",                    precision: 10, scale: 2, default: 0.0,   null: false
    t.integer  "product_type_id", limit: 4
    t.boolean  "saleable_online", limit: 1,                              default: false, null: false
    t.boolean  "active",          limit: 1,                              default: false, null: false
    t.string   "type",            limit: 255
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.datetime "deleted_at"
  end

  add_index "products", ["deleted_at"], name: "index_products_on_deleted_at", using: :btree
  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree
  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree

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

  create_table "receipts", force: :cascade do |t|
    t.string   "code",           limit: 255
    t.decimal  "amount",                       precision: 10, scale: 2
    t.integer  "payment_method", limit: 4,                              default: 1, null: false
    t.text     "payment_info",   limit: 65535
    t.integer  "order_id",       limit: 4
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
  end

  add_index "receipts", ["order_id"], name: "index_receipts_on_order_id", using: :btree
  add_index "receipts", ["user_id"], name: "index_receipts_on_user_id", using: :btree

  create_table "requirement_item_customisations", force: :cascade do |t|
    t.integer  "requirement_item_id", limit: 4
    t.integer  "specification_id",    limit: 4
    t.string   "value",               limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "requirement_item_customisations", ["requirement_item_id"], name: "index_requirement_item_customisations_on_requirement_item_id", using: :btree
  add_index "requirement_item_customisations", ["specification_id"], name: "index_requirement_item_customisations_on_specification_id", using: :btree

  create_table "requirement_item_image_customisations", force: :cascade do |t|
    t.integer  "requirement_item_id",     limit: 4
    t.integer  "characteristic_id",       limit: 4
    t.integer  "characteristic_image_id", limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "requirement_item_image_customisations", ["characteristic_id"], name: "index_characterisic_riic", using: :btree
  add_index "requirement_item_image_customisations", ["characteristic_image_id"], name: "index_char_img_riic", using: :btree
  add_index "requirement_item_image_customisations", ["requirement_item_id"], name: "index_req_item_riic", using: :btree

  create_table "requirement_items", force: :cascade do |t|
    t.integer  "requirement_id", limit: 4
    t.integer  "product_id",     limit: 4
    t.string   "name",           limit: 255
    t.integer  "quantity",       limit: 4
    t.decimal  "price",                        precision: 10, scale: 2
    t.text     "description",    limit: 65535
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "requirement_items", ["product_id"], name: "index_requirement_items_on_product_id", using: :btree
  add_index "requirement_items", ["requirement_id"], name: "index_requirement_items_on_requirement_id", using: :btree

  create_table "requirements", force: :cascade do |t|
    t.integer  "customer_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "outlet_id",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "requirements", ["customer_id"], name: "index_requirements_on_customer_id", using: :btree
  add_index "requirements", ["outlet_id"], name: "index_requirements_on_outlet_id", using: :btree
  add_index "requirements", ["user_id"], name: "index_requirements_on_user_id", using: :btree

  create_table "role_permissions", force: :cascade do |t|
    t.integer  "role_id",       limit: 4
    t.integer  "permission_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "role_permissions", ["permission_id"], name: "index_role_permissions_on_permission_id", using: :btree
  add_index "role_permissions", ["role_id"], name: "index_role_permissions_on_role_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.decimal  "discount_percent",             precision: 10, scale: 2, default: 0.0, null: false
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
  end

  create_table "sales_relationships", force: :cascade do |t|
    t.integer  "product_id",         limit: 4
    t.integer  "related_product_id", limit: 4
    t.string   "type",               limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "sales_relationships", ["product_id"], name: "index_sales_relationships_on_product_id", using: :btree
  add_index "sales_relationships", ["related_product_id"], name: "index_sales_relationships_on_related_product_id", using: :btree

  create_table "specifications", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "required",   limit: 1,   default: false, null: false
    t.string   "units",      limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "stock_notifications", force: :cascade do |t|
    t.integer  "customer_id", limit: 4, null: false
    t.integer  "product_id",  limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "stock_notifications", ["customer_id", "product_id"], name: "index_stock_notifications_on_customer_id_and_product_id", unique: true, using: :btree
  add_index "stock_notifications", ["customer_id"], name: "index_stock_notifications_on_customer_id", using: :btree
  add_index "stock_notifications", ["product_id"], name: "index_stock_notifications_on_product_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.integer  "quantity",   limit: 4
    t.integer  "product_id", limit: 4
    t.integer  "outlet_id",  limit: 4
    t.text     "details",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "stocks", ["outlet_id"], name: "index_stocks_on_outlet_id", using: :btree
  add_index "stocks", ["product_id"], name: "index_stocks_on_product_id", using: :btree

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

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "role_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "username",               limit: 255
    t.string   "password_digest",        limit: 255
    t.string   "email",                  limit: 255
    t.integer  "phone",                  limit: 8
    t.string   "address",                limit: 255
    t.integer  "pincode",                limit: 4
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "country",                limit: 255
    t.integer  "outlet_id",              limit: 4
    t.boolean  "active",                 limit: 1,   default: false, null: false
    t.integer  "flags",                  limit: 4,   default: 0,     null: false
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "users", ["outlet_id"], name: "index_users_on_outlet_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "workshop_image_logs", force: :cascade do |t|
    t.integer  "user_id",                           limit: 4
    t.string   "info",                              limit: 255
    t.integer  "order_item_image_customisation_id", limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "workshop_image_logs", ["order_item_image_customisation_id"], name: "index_workshop_image_logs_on_order_item_image_customisation_id", using: :btree
  add_index "workshop_image_logs", ["user_id"], name: "index_workshop_image_logs_on_user_id", using: :btree

  create_table "workshop_logs", force: :cascade do |t|
    t.integer  "user_id",                     limit: 4
    t.string   "info",                        limit: 255
    t.integer  "order_item_customisation_id", limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "workshop_logs", ["order_item_customisation_id"], name: "index_workshop_logs_on_order_item_customisation_id", using: :btree
  add_index "workshop_logs", ["user_id"], name: "index_workshop_logs_on_user_id", using: :btree

  add_foreign_key "banner_categories", "banners"
  add_foreign_key "banner_categories", "categories"
  add_foreign_key "cart_item_customisations", "cart_items"
  add_foreign_key "cart_item_customisations", "specifications"
  add_foreign_key "cart_item_image_customisations", "cart_items"
  add_foreign_key "cart_item_image_customisations", "characteristic_images"
  add_foreign_key "cart_item_image_customisations", "characteristics"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
  add_foreign_key "carts", "customers"
  add_foreign_key "carts", "outlets"
  add_foreign_key "carts", "users"
  add_foreign_key "category_coupons", "categories"
  add_foreign_key "category_coupons", "coupon_codes"
  add_foreign_key "characteristic_images", "characteristics"
  add_foreign_key "group_items", "products"
  add_foreign_key "group_items", "products", column: "related_product_id"
  add_foreign_key "invoices", "customers"
  add_foreign_key "online_cart_items", "online_carts"
  add_foreign_key "online_cart_items", "products"
  add_foreign_key "online_carts", "coupon_codes"
  add_foreign_key "online_carts", "customers"
  add_foreign_key "online_order_items", "online_orders"
  add_foreign_key "online_order_items", "products"
  add_foreign_key "online_order_taxes", "online_orders"
  add_foreign_key "online_orders", "coupon_codes"
  add_foreign_key "online_orders", "customers"
  add_foreign_key "order_item_customisations", "order_items"
  add_foreign_key "order_item_customisations", "specifications"
  add_foreign_key "order_item_customisations", "users"
  add_foreign_key "order_item_image_customisations", "characteristic_images"
  add_foreign_key "order_item_image_customisations", "characteristics"
  add_foreign_key "order_item_image_customisations", "order_items"
  add_foreign_key "order_item_image_customisations", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "order_taxes", "orders"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "invoices"
  add_foreign_key "orders", "outlets"
  add_foreign_key "orders", "users"
  add_foreign_key "product_categories", "categories"
  add_foreign_key "product_categories", "products"
  add_foreign_key "product_characteristics", "characteristic_images"
  add_foreign_key "product_characteristics", "characteristics"
  add_foreign_key "product_characteristics", "products"
  add_foreign_key "product_coupons", "coupon_codes"
  add_foreign_key "product_coupons", "products"
  add_foreign_key "product_images", "products"
  add_foreign_key "product_specifications", "products"
  add_foreign_key "product_specifications", "specifications"
  add_foreign_key "product_type_taxes", "product_types"
  add_foreign_key "product_type_taxes", "taxes"
  add_foreign_key "products", "product_types"
  add_foreign_key "quotation_products", "products"
  add_foreign_key "quotation_products", "quotations"
  add_foreign_key "quotations", "customers"
  add_foreign_key "quotations", "users"
  add_foreign_key "receipts", "orders"
  add_foreign_key "receipts", "users"
  add_foreign_key "requirement_item_customisations", "requirement_items"
  add_foreign_key "requirement_item_customisations", "specifications"
  add_foreign_key "requirement_item_image_customisations", "characteristic_images"
  add_foreign_key "requirement_item_image_customisations", "characteristics"
  add_foreign_key "requirement_item_image_customisations", "requirement_items"
  add_foreign_key "requirement_items", "products"
  add_foreign_key "requirement_items", "requirements"
  add_foreign_key "requirements", "customers"
  add_foreign_key "requirements", "outlets"
  add_foreign_key "requirements", "users"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "sales_relationships", "products"
  add_foreign_key "sales_relationships", "products", column: "related_product_id"
  add_foreign_key "stock_notifications", "customers"
  add_foreign_key "stock_notifications", "products"
  add_foreign_key "stocks", "outlets"
  add_foreign_key "stocks", "products"
  add_foreign_key "user_permissions", "permissions"
  add_foreign_key "user_permissions", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
  add_foreign_key "users", "outlets"
  add_foreign_key "workshop_image_logs", "order_item_image_customisations"
  add_foreign_key "workshop_image_logs", "users"
  add_foreign_key "workshop_logs", "order_item_customisations"
  add_foreign_key "workshop_logs", "users"
end
