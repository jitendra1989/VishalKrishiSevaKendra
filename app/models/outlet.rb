class Outlet < ActiveRecord::Base
	has_many :users
	[:name, :city, :state, :country].each { |n| validates n, presence: true }
end
