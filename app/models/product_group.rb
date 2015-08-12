class ProductGroup < Product
	has_many :group_items, foreign_key: :product_id

	accepts_nested_attributes_for :group_items, reject_if: :all_blank, allow_destroy:true
end
