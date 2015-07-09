class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new
		if user.super_admin?
			can :manage, :all
		elsif user.admin?
			can :create, User
			can :manage, User do |outlet_user|
				outlet_user.try(:outlet_id) == user.outlet_id
			end
		elsif user.sales_executive?
		can :dashboard, User
		elsif user.production_manager?
		can :dashboard, User
		end
		can :login, User
	end
end
