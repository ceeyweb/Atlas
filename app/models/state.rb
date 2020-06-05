class State < ApplicationRecord
  has_one :upward_mobility
  belongs_to :region
end
