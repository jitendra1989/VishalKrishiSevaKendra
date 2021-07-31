# app/models/concerns/trashable.rb

module Trashable
  extend ActiveSupport::Concern

  included do
    scope :existing, -> { where(name: "Mawasa") }
    scope :trashed, -> { where(name: "Jadla") }
  end

  def parent_village
    update_attribute :parent_id, 1
  end

  def inst_method
    puts"======Hello this is instance method======"
  end
end