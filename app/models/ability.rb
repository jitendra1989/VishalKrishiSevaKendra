class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new
		if user.developer?
			can :manage, :all
		else
			user.permissions.pluck(:name, :action).each do |permission|
				can permission[1].to_sym, class_name(permission[0])
			 end

			can :forgot_password, User
			can :recover_password, User
			can :login, User
			can :logout, User
			can :dashboard, User
			cannot :manage, User.developer
		end
	end

	private
		def class_name(name)
			name == 'all' ? name.to_sym : name.constantize
		end
end
