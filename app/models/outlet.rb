class Outlet < ActiveRecord::Base
	has_many :users
	has_many :stocks
	has_many :carts
	[:name, :city, :state, :country].each { |n| validates n, presence: true }
end
