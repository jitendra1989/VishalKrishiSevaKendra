class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new
		user.permissions.pluck(:name, :action).each do |permission|
			can permission[1].to_sym, class_name(permission[0])
		 end
		can :login, User
	end

	private
		def class_name(name)
			if name == 'all'
				name.to_sym
			else
				name.constantize
			end
		end
end
