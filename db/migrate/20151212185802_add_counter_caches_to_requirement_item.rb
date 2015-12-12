class AddCounterCachesToRequirementItem < ActiveRecord::Migration
  def change
  	add_column :requirement_items, :customisations_count, :integer, default: 0, null: false, after: :description
  	add_column :requirement_items, :image_customisations_count, :integer, default: 0, null: false, after: :customisations_count
  	add_column :requirement_items, :customer_customisations_count, :integer, default: 0, null: false, after: :image_customisations_count
  end
end
