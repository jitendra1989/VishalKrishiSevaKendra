class ProductGroup < Product
	has_many :group_items, foreign_key: :product_id
	has_many :grouped_products, through: :group_items, source: :related_product

	accepts_nested_attributes_for :group_items, reject_if: :all_blank, allow_destroy:true

	attr_accessor :new_quantity, :stock_code, :supplier_name, :invoice_date, :invoice_number, :stock_outlet_id

	before_save :add_stock

	def outlet_stock_quantity(outlet)
		item_stock = []
		self.group_items.includes(:related_product).each do |group_item|
			item_stock << group_item.related_product.outlet_stock_quantity(outlet)/ group_item.quantity
		end
		item_stock.min || 0
	end

	def online_stock
		item_stock = []
		self.group_items.includes(:related_product).each do |group_item|
			item_stock << group_item.related_product.online_stock/ group_item.quantity
		end
		item_stock.min || 0
	end

	private
		def add_stock
			if self.new_quantity && self.new_quantity.to_i > 0
				self.group_items.each do |group_item|
					group_item.related_product.stocks << Stock.create(new_quantity: self.new_quantity.to_i * group_item.quantity, code: self.stock_code, supplier_name: self.supplier_name,invoice_date: self.invoice_date, invoice_number: self.invoice_number, outlet_id: self.stock_outlet_id)
				end
			end
		end
end
