class Role < ActiveRecord::Base
	has_many :role_permissions, dependent: :destroy
	has_many :permissions, through: :role_permissions
	has_many :user_roles, dependent: :destroy
	has_many :users, through: :user_roles
	validates :name, presence: true, uniqueness: true
end
