class Banner < ActiveRecord::Base
	validates :name, presence: true
end
