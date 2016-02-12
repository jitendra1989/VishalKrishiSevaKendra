class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new

		if user.regular?
			user.permissions.pluck(:name, :action).each do |permission|
				can permission[1].to_sym, class_name(permission[0])
			 end
			cannot :manage, User.developer
			cannot :manage, User.main_boss
			cannot :manage, User.store_boss
			cannot :flag, Order
		elsif user.store_boss?
			can :manage, user.outlet
			can :manage, User do |u|
				u.outlet == user.outlet
			end
		elsif user.main_boss?
			can :manage, :all
			cannot :manage, User.developer
		elsif user.developer?
			can :manage, :all
		end

		can :forgot_password, User
		can :recover_password, User
		can :login, User
		can :logout, User
		can :dashboard, User

		if user.workshop_user?
			can :manage, OrderItemImageCustomisation do |c|
				c.user == user
			end
			can :manage, OrderItemCustomisation do |c|
				c.user == user
			end
		end
	end

	private
		def class_name(name)
			name == 'all' ? name.to_sym : name.constantize
		end
end
