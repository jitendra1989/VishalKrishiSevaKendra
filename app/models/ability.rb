class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new
		user.permissions.each do |permission|
			 if permission.subject_id.nil?
				 can permission.action.to_sym, class_name(permission.subject_class)
			 else
				 can permission.action.to_sym, class_name(permission.subject_class), id: permission.subject_id
			 end
		 end
		can :login, User
	end

	private
		def class_name(subject_class)
			if subject_class == 'all'
				subject_class.to_sym
			else
				subject_class.constantize
			end
		end
end
