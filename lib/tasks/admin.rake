namespace :admin do
	desc "Populate permissions based on admin controller actions"
	task permissions: :environment do
		setup_permissions
	end

	private
		def setup_permissions
			write_permission("all", "manage", "Every Action", true)

			controllers = Dir.new("#{Rails.root}/app/controllers/admin").entries
			controllers.each do |controller|
				if controller =~ /_controller/
					"Admin::#{controller.camelize.gsub('.rb','')}".constantize.new
				end
			end

			Admin::ApplicationController.subclasses.each do |controller|
				if controller.respond_to?(:permission)
					klass = controller.permission
					write_permission(klass, "manage", "All operations")
					controller.action_methods.each do |action|
						if action.to_s.index("_callback").nil?
							action_desc, cancan_action = eval_cancan_action(action)
							write_permission(klass, cancan_action, action_desc)
						end
					end
				end
			end
		end

		def eval_cancan_action(action)
			case action.to_s
			when "index", "show"
				cancan_action = "read"
				action_desc = "Read-only"
			when "create", "new"
				cancan_action = "create"
				action_desc = "Insert only"
			when "edit", "update"
				cancan_action = "update"
				action_desc = "Update Only"
			when "delete", "destroy"
				cancan_action = "delete"
				action_desc = "Delete Only"
			else
				cancan_action = action.to_s
				action_desc = cancan_action.capitalize
			end
			return action_desc, cancan_action
		end

		def write_permission(class_name, cancan_action, description, force_id_1 = false)
			permission = Permission.find_or_initialize_by(name: class_name, action: cancan_action)
			unless permission
				permission.id = 1 if force_id_1
			end
			permission.description = description
			permission.save
		end
end
