class Permission < ActiveRecord::Base
	[:name, :subject_class, :action, :description].each { |n| validates n, presence: true }
end
