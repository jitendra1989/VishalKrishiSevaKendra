class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new
		if user.super_admin?
			can :manage, :all
		else
			can :create, User
			can :manage, User do |outlet_user|
				outlet_user.try(:outlet_id) == user.outlet_id
			end
		end
	end
end
