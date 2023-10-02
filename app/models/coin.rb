class Coin < ApplicationRecord
  belongs_to :mining_type
  validates :description, :acronym, :url_image, :mining_type_id, presence: true
end