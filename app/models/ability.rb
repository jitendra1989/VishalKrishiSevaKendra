class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new
		if user.super_admin?
			can :manage, :all
			cannot :create, User do |admin|
				admin.role == User::ROLES.first
			end
		elsif user.admin?
			can :create, User do |admin|
				User::ROLES.slice(0, 2).exclude?(admin.try :role)
			end
			can :update, user
			can :manage, User do |admin|
				admin.try(:outlet_id) == user.outlet_id && User::ROLES.slice(0, 2).exclude?(admin.try :role)
			end
		elsif user.sales_executive?
		elsif user.production_manager?
		end
		if user.persisted?
			can :logout, User
			can :dashboard, User
		end
		can :login, User
	end
end
