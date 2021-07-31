class Village < ApplicationRecord
  belongs_to :parent, :class_name => 'Village'
  has_many :sub_villages, :class_name => 'Village', :foreign_key => 'parent_id'

  before_create :before_create_mth
  before_save :before_save_mth

  include MyModule
  # extend MyModule
  include Trashable



  def before_save_mth
    puts"====before_save_mth====="
  end

  def before_create_mth
    puts"====before_create_mth====="
  end

  def test
    puts "this is instance method"
  end


  def self.test2
    puts "this is class method"
  end

end


