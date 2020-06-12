class UpwardMobility < ApplicationRecord
  belongs_to :state
  has_many :upward_mobility_indicators
  has_many :indicators, through: :upward_mobility_indicators
  has_one :region, through: :state
end
