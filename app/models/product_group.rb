class ProductGroup < Product
	has_many :group_items, foreign_key: :product_id
	has_many :grouped_products, through: :group_items, source: :related_product

	accepts_nested_attributes_for :group_items, reject_if: :all_blank, allow_destroy:true

	def outlet_stock_quantity(outlet)
		item_stock = []
		self.group_items.includes(:related_product).each do |group_item|
			item_stock << group_item.related_product.outlet_stock_quantity(outlet)/ group_item.quantity
		end
		item_stock.min
	end

	def online_stock
		item_stock = []
		self.group_items.includes(:related_product).each do |group_item|
			item_stock << group_item.related_product.online_stock/ group_item.quantity
		end
		item_stock.min
	end
end
