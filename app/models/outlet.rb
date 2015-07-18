class Outlet < ActiveRecord::Base
	has_many :users, -> { where 'role != ?', 'super_admin' }
	has_many :stock
	[:name, :city, :state, :country].each { |n| validates n, presence: true }
end
