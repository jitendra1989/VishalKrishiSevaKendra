class Outlet < ActiveRecord::Base
	[:name, :city, :state, :country].each { |n| validates n, presence: true }
end
