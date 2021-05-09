# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_09_031704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "banner_categories", id: :serial, force: :cascade do |t|
    t.integer "banner_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["banner_id"], name: "index_banner_categories_on_banner_id"
    t.index ["category_id"], name: "index_banner_categories_on_category_id"
  end

  create_table "banners", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location"
  end

  create_table "cart_item_customisations", id: :serial, force: :cascade do |t|
    t.integer "cart_item_id"
    t.integer "specification_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_cart_item_customisations_on_cart_item_id"
    t.index ["specification_id"], name: "index_cart_item_customisations_on_specification_id"
  end

  create_table "cart_item_image_customisations", id: :serial, force: :cascade do |t|
    t.integer "cart_item_id"
    t.integer "characteristic_id"
    t.integer "characteristic_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_item_id"], name: "index_cart_item_image_customisations_on_cart_item_id"
    t.index ["characteristic_id"], name: "index_cart_item_image_customisations_on_characteristic_id"
    t.index ["characteristic_image_id"], name: "index_cart_item_image_customisations_on_characteristic_image_id"
  end

  create_table "cart_items", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "cart_id"
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customisations_count", default: 0, null: false
    t.integer "image_customisations_count", default: 0, null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.integer "user_id"
    t.integer "outlet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_carts_on_customer_id"
    t.index ["outlet_id", "customer_id"], name: "index_carts_on_outlet_id_and_customer_id", unique: true
    t.index ["outlet_id"], name: "index_carts_on_outlet_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "casts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.string "slug"
    t.text "description"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "category_coupons", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.integer "coupon_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_coupons_on_category_id"
    t.index ["coupon_code_id"], name: "index_category_coupons_on_coupon_code_id"
  end

  create_table "characteristic_images", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "characteristic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.index ["characteristic_id"], name: "index_characteristic_images_on_characteristic_id"
  end

  create_table "characteristics", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_pages", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "menu", default: false, null: false
    t.string "link_text"
    t.string "image"
  end

  create_table "coupon_codes", id: :serial, force: :cascade do |t|
    t.string "code"
    t.decimal "percent", precision: 10, scale: 2
    t.boolean "active", default: false, null: false
    t.datetime "active_from"
    t.datetime "active_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "mobile"
    t.bigint "phone"
    t.string "address"
    t.integer "pincode"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "company_name"
    t.string "company_address"
    t.bigint "company_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "orders_count", default: 0, null: false
    t.string "activation_digest"
    t.boolean "activated", default: false, null: false
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.index ["deleted_at"], name: "index_customers_on_deleted_at"
  end

  create_table "group_items", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "related_product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_group_items_on_product_id"
    t.index ["related_product_id"], name: "index_group_items_on_related_product_id"
  end

  create_table "invoices", id: :serial, force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
  end

  create_table "online_cart_items", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "online_cart_id"
    t.integer "quantity", default: 0, null: false
    t.integer "integer", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["online_cart_id"], name: "index_online_cart_items_on_online_cart_id"
    t.index ["product_id"], name: "index_online_cart_items_on_product_id"
  end

  create_table "online_carts", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "blocked_at"
    t.integer "coupon_code_id"
    t.index ["coupon_code_id"], name: "index_online_carts_on_coupon_code_id"
    t.index ["customer_id"], name: "index_online_carts_on_customer_id"
  end

  create_table "online_order_items", id: :serial, force: :cascade do |t|
    t.integer "online_order_id"
    t.integer "product_id"
    t.string "name"
    t.integer "quantity"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "discount_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.index ["online_order_id"], name: "index_online_order_items_on_online_order_id"
    t.index ["product_id"], name: "index_online_order_items_on_product_id"
  end

  create_table "online_order_taxes", id: :serial, force: :cascade do |t|
    t.integer "online_order_id"
    t.string "name"
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "percentage", default: 0.0, null: false
    t.index ["online_order_id"], name: "index_online_order_taxes_on_online_order_id"
  end

  create_table "online_orders", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "subtotal", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "tax_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.text "payment_info"
    t.integer "coupon_code_id"
    t.index ["coupon_code_id"], name: "index_online_orders_on_coupon_code_id"
    t.index ["customer_id"], name: "index_online_orders_on_customer_id"
  end

  create_table "online_taxes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "percentage", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.boolean "fully_taxable", default: true, null: false
    t.index ["ancestry"], name: "index_online_taxes_on_ancestry"
  end

  create_table "order_item_customisations", id: :serial, force: :cascade do |t|
    t.integer "order_item_id"
    t.integer "specification_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.integer "user_id"
    t.index ["order_item_id"], name: "index_order_item_customisations_on_order_item_id"
    t.index ["specification_id"], name: "index_order_item_customisations_on_specification_id"
    t.index ["user_id"], name: "index_order_item_customisations_on_user_id"
  end

  create_table "order_item_image_customisations", id: :serial, force: :cascade do |t|
    t.integer "order_item_id"
    t.integer "characteristic_id"
    t.integer "characteristic_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.integer "user_id"
    t.index ["characteristic_id"], name: "characteristic"
    t.index ["characteristic_image_id"], name: "characteristic_image"
    t.index ["order_item_id"], name: "order_item"
    t.index ["user_id"], name: "index_order_item_image_customisations_on_user_id"
  end

  create_table "order_items", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.string "name"
    t.integer "quantity"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customisations_count", default: 0, null: false
    t.integer "image_customisations_count", default: 0, null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_taxes", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.string "name"
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "percentage", default: 0.0, null: false
    t.index ["order_id"], name: "index_order_taxes_on_order_id"
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.integer "user_id"
    t.integer "outlet_id"
    t.decimal "discount_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "receipts_count", default: 0, null: false
    t.decimal "subtotal", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "tax_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "invoice_id"
    t.boolean "overridden", default: false, null: false
    t.text "details"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["invoice_id"], name: "index_orders_on_invoice_id"
    t.index ["outlet_id"], name: "index_orders_on_outlet_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "outlets", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "state"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "online_store", default: false, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_outlets_on_deleted_at"
  end

  create_table "permissions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "action"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "product_characteristics", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "characteristic_id"
    t.integer "characteristic_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["characteristic_id"], name: "index_product_characteristics_on_characteristic_id"
    t.index ["characteristic_image_id"], name: "index_product_characteristics_on_characteristic_image_id"
    t.index ["product_id", "characteristic_id"], name: "product_characteristic", unique: true
    t.index ["product_id"], name: "index_product_characteristics_on_product_id"
  end

  create_table "product_coupons", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "coupon_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_code_id"], name: "index_product_coupons_on_coupon_code_id"
    t.index ["product_id"], name: "index_product_coupons_on_product_id"
  end

  create_table "product_images", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "product_specifications", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "specification_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_specifications_on_product_id"
    t.index ["specification_id"], name: "index_product_specifications_on_specification_id"
  end

  create_table "product_type_taxes", id: :serial, force: :cascade do |t|
    t.integer "product_type_id"
    t.integer "tax_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.boolean "fully_taxable", default: true, null: false
    t.index ["product_type_id"], name: "index_product_type_taxes_on_product_type_id"
    t.index ["tax_id"], name: "index_product_type_taxes_on_tax_id"
  end

  create_table "product_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "require_workshop", default: false, null: false
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.decimal "price", precision: 10, scale: 2
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_type_id"
    t.string "slug"
    t.decimal "sale_price", precision: 10, scale: 2, default: "0.0", null: false
    t.boolean "saleable_online", default: false, null: false
    t.datetime "deleted_at"
    t.string "type"
    t.boolean "customised", default: false, null: false
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["product_type_id"], name: "index_products_on_product_type_id"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "quotation_products", id: :serial, force: :cascade do |t|
    t.integer "quotation_id"
    t.integer "product_id"
    t.string "name"
    t.integer "quantity", default: 1, null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_quotation_products_on_product_id"
    t.index ["quotation_id"], name: "index_quotation_products_on_quotation_id"
  end

  create_table "quotations", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.integer "user_id"
    t.decimal "discount_amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_quotations_on_customer_id"
    t.index ["user_id"], name: "index_quotations_on_user_id"
  end

  create_table "receipts", id: :serial, force: :cascade do |t|
    t.string "code"
    t.decimal "amount", precision: 10, scale: 2
    t.integer "order_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_method", default: 1, null: false
    t.text "payment_info"
    t.index ["order_id"], name: "index_receipts_on_order_id"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "requirement_item_customer_customisations", id: :serial, force: :cascade do |t|
    t.integer "requirement_item_id"
    t.string "name"
    t.string "image"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requirement_item_id"], name: "index_req_item_ricc"
  end

  create_table "requirement_item_customisations", id: :serial, force: :cascade do |t|
    t.integer "requirement_item_id"
    t.integer "specification_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requirement_item_id"], name: "index_requirement_item_customisations_on_requirement_item_id"
    t.index ["specification_id"], name: "index_requirement_item_customisations_on_specification_id"
  end

  create_table "requirement_item_image_customisations", id: :serial, force: :cascade do |t|
    t.integer "requirement_item_id"
    t.integer "characteristic_id"
    t.integer "characteristic_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["characteristic_id"], name: "index_characterisic_riic"
    t.index ["characteristic_image_id"], name: "index_char_img_riic"
    t.index ["requirement_item_id"], name: "index_req_item_riic"
  end

  create_table "requirement_items", id: :serial, force: :cascade do |t|
    t.integer "requirement_id"
    t.integer "product_id"
    t.string "name"
    t.integer "quantity", default: 1, null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customisations_count", default: 0, null: false
    t.integer "image_customisations_count", default: 0, null: false
    t.integer "customer_customisations_count", default: 0, null: false
    t.index ["product_id"], name: "index_requirement_items_on_product_id"
    t.index ["requirement_id"], name: "index_requirement_items_on_requirement_id"
  end

  create_table "requirements", id: :serial, force: :cascade do |t|
    t.integer "customer_id"
    t.integer "user_id"
    t.integer "outlet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_requirements_on_customer_id"
    t.index ["outlet_id"], name: "index_requirements_on_outlet_id"
    t.index ["user_id"], name: "index_requirements_on_user_id"
  end

  create_table "role_permissions", id: :serial, force: :cascade do |t|
    t.integer "role_id"
    t.integer "permission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "discount_percent", precision: 10, scale: 2, default: "0.0", null: false
  end

  create_table "sales_relationships", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "related_product_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sales_relationships_on_product_id"
    t.index ["related_product_id"], name: "index_sales_relationships_on_related_product_id"
  end

  create_table "specifications", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "required", default: false, null: false
    t.string "units"
  end

  create_table "stock_notifications", id: :serial, force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "product_id"], name: "index_stock_notifications_on_customer_id_and_product_id", unique: true
    t.index ["customer_id"], name: "index_stock_notifications_on_customer_id"
    t.index ["product_id"], name: "index_stock_notifications_on_product_id"
  end

  create_table "stocks", id: :serial, force: :cascade do |t|
    t.integer "quantity"
    t.integer "product_id"
    t.integer "outlet_id"
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["outlet_id"], name: "index_stocks_on_outlet_id"
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  create_table "taxes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_permissions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "permission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_user_permissions_on_permission_id"
    t.index ["user_id"], name: "index_user_permissions_on_user_id"
  end

  create_table "user_roles", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.bigint "phone"
    t.string "address"
    t.integer "pincode"
    t.string "city"
    t.string "state"
    t.string "country"
    t.boolean "active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "outlet_id"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer "flags", default: 0, null: false
    t.index ["outlet_id"], name: "index_users_on_outlet_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "workshop_image_logs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "info"
    t.integer "order_item_image_customisation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_item_image_customisation_id"], name: "index_workshop_image_logs_on_order_item_image_customisation_id"
    t.index ["user_id"], name: "index_workshop_image_logs_on_user_id"
  end

  create_table "workshop_logs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "info"
    t.integer "order_item_customisation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_item_customisation_id"], name: "index_workshop_logs_on_order_item_customisation_id"
    t.index ["user_id"], name: "index_workshop_logs_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
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
  add_foreign_key "requirement_item_customer_customisations", "requirement_items"
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
