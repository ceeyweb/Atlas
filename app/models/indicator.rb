class Indicator < ApplicationRecord
  has_many :upward_mobility_indicators
  has_many :upward_mobilities, through: :upward_mobility_indicators
end
