class BannerCategory < ApplicationRecord
  belongs_to :banner
  belongs_to :category
end
