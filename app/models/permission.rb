class Permission < ActiveRecord::Base
	has_many :user_permissions
	has_many :users, through: :user_permissions
	[:name, :subject_class, :action, :description].each { |n| validates n, presence: true }
end
