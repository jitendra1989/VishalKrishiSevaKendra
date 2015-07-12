class Outlet < ActiveRecord::Base
	has_many :users, -> { where 'role != ?', 'super_admin' }
	[:name, :city, :state, :country].each { |n| validates n, presence: true }
end
