class Product < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name, use: :slugged

	acts_as_paranoid

	has_many :product_categories, dependent: :destroy
	has_many :stocks
	has_many :cart_items, dependent: :destroy
	has_many :online_cart_items, dependent: :destroy
	belongs_to :product_type
	has_many :categories, through: :product_categories
	has_many :images, class_name: ProductImage, dependent: :destroy
	has_many :sales_relationships, dependent: :destroy
	has_many :cross_sells
	has_many :cross_sale_products, through: :cross_sells, source: :related_product
	has_many :product_specifications
	has_many :specifications, through: :product_specifications, dependent: :destroy
	has_many :product_characteristics
	has_many :characteristics, through: :product_characteristics, dependent: :destroy
	has_many :product_coupons, dependent: :destroy
	has_many :coupon_codes, through: :product_coupons
	has_many :inverse_group_items, class_name: GroupItem, foreign_key: :related_product_id, dependent: :destroy
	has_many :groupings, through: :inverse_group_items, source: :product #product group

	delegate :taxes, to: :product_type

	[:name, :code, :description, :product_type_id].each { |n| validates n, presence: true }
	[:price, :sale_price].each { |n| validates n, numericality: true }
	validates :sale_price, numericality: { less_than: :price }, if: :price

	scope :customised, -> { where(customised: true) }
	scope :mass_produced, -> { where(customised: false) }
	scope :online, -> { where(saleable_online: true) }
	scope :grouped, -> { where(type: 'ProductGroup') }
	scope :simple, -> { where(type: nil) }

	accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy:true
	accepts_nested_attributes_for :product_specifications, reject_if: :all_blank, allow_destroy:true
	accepts_nested_attributes_for :product_characteristics, reject_if: :all_blank, allow_destroy:true

	attr_writer :current_step
	attr_accessor :requirement_id

	def current_step
		@current_step || steps.first
	end

	def next_step
		self.current_step = steps[steps.index(current_step)+1]
	end

	def previous_step
		self.current_step = steps[steps.index(current_step)-1]
	end

	def first_step?
		current_step == steps.first
	end

	def last_step?
		current_step == steps.last
	end

	def steps
		%w[info images categories crosssell specifications image_specifications coupons]
	end

	def outlet_stock_quantity(outlet)
		self.stocks.where(outlet: outlet).last.try(:quantity) || 0
	end

	def tax_amount(taxable_amount)
		tax_calculator(ProductType.find(self.product_type_id).product_type_taxes.includes(:tax).arrange, taxable_amount, 0)
	end

	def tax_amount_breakup(taxable_amount)
		tax_calculator_breakup(ProductType.find(self.product_type_id).product_type_taxes.includes(:tax).arrange, taxable_amount, 0)
	end

	def price_with_taxes
		self.price + tax_amount(self.price)
	end

	def sale_price_with_taxes
		self.sale_price + tax_amount(self.sale_price)
	end

	def actual_price_without_taxes
		self.sale_price > 0 ? self.sale_price : self.price
	end

	def online_tax_amount(taxable_amount)
		online_tax_calculator(OnlineTax.all.arrange, taxable_amount, 0)
	end

	def price_with_online_taxes
		self.price + online_tax_amount(self.price)
	end

	def sale_price_with_online_taxes
		self.sale_price + online_tax_amount(self.sale_price)
	end

	def online_stock
		stock = 0
		Outlet.online_outlets.each do |online_outlet|
			stock += online_outlet.product_stock(self).try(:quantity) || 0
		end
		stock
	end

	def add_to_online_cart(quantity, cart_id)
		if online_stock > 0
			total_added_quantity = 0
			Outlet.online_outlets.each do |online_outlet|
				added_quantity = online_outlet.product_stock(self).try(:add_to_cart, quantity, cart_id) || 0
				total_added_quantity += added_quantity
				quantity -= added_quantity
				break if quantity <= 0
			end
			total_added_quantity
		else
			0
		end
	end

	def online_price
		self.sale_price > 0 ? self.sale_price : self.price
	end

	def final_price_with_taxes
		self.sale_price > 0 ? self.sale_price_with_taxes : self.price_with_taxes
	end

	def final_online_price_with_taxes
		self.sale_price > 0 ? self.sale_price_with_online_taxes : self.price_with_online_taxes
	end

	def self.types
		%w(ProductGroup)
	end

	private

		def online_tax_calculator(hash, parent_amount = 0, taxable_amount = 0, amount = 0)
			hash.each do |tax, children|
				level_amount = tax_conditional(tax, parent_amount, taxable_amount, tax.percentage)
				amount = online_tax_calculator(children, parent_amount, level_amount) unless children.empty?
				amount += level_amount
			end
			amount
		end

		def tax_calculator(hash, parent_amount = 0, taxable_amount = 0, amount = 0)
			hash.each do |tax, children|
				level_amount = tax_conditional(tax, parent_amount, taxable_amount, tax.tax.percentage)
				amount = tax_calculator(children, parent_amount, level_amount) unless children.empty?
				amount += level_amount
			end
			amount
		end

		def tax_calculator_breakup(hash, parent_amount = 0, taxable_amount = 0, groups = {})
			hash.each do |tax, children|
				level_amount = tax_conditional(tax, parent_amount, taxable_amount, tax.tax.percentage)
				groups[tax.tax.name] = { amount: level_amount, percentage: tax.tax.percentage }
				groups.merge(tax_calculator_breakup(children, parent_amount, level_amount, groups)) unless children.empty?
			end
			groups
		end

		def tax_conditional(tax, parent_amount, taxable_amount, percentage)
			if tax.fully_taxable? || tax.root?
				level_amount = (parent_amount + taxable_amount) * percentage/100
			else
				level_amount = taxable_amount * percentage/100
			end
		end
end
