class Outlet < ActiveRecord::Base
	has_many :users
	has_many :stocks
	[:name, :city, :state, :country].each { |n| validates n, presence: true }
end
