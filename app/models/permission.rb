class Permission < ActiveRecord::Base
	has_many :user_permissions
	has_many :users, through: :user_permissions
	has_many :role_permissions
	has_many :roles, through: :role_permissions
	[:name, :subject_class, :action, :description].each { |n| validates n, presence: true }

	def name_with_description
		"#{name}, #{description}"
	end
end
