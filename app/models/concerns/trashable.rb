# app/models/concerns/trashable.rb

module Trashable
  extend ActiveSupport::Concern

  included do
    # scope :existing, -> { where(name: "Mawasa") }
    # scope :trashed, -> { where(name: "Jadla") }
    second_class_method
  end

  # class_methods do
  #   def a1
  #     puts "concern class methods"
  #   end
  # end
  #
  # def parent_village
  #   update_attribute :parent_id, 1
  # end
  #
  # def inst_method
  #   puts"======Hello this is instance method======"
  # end





  module ClassMethods
    def first_class_method
      puts"======first_class_method======="
    end

    def second_class_method
      puts"======second_class_method======="
    end
  end
end