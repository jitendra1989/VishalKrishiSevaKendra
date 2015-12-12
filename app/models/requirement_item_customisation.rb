class RequirementItemCustomisation < ActiveRecord::Base
  belongs_to :requirement_item, counter_cache: :customisations_count
  belongs_to :specification
  [:requirement_item_id, :specification_id, :value].each{ |n| validates n, presence: true }
end
