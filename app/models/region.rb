class Region < ApplicationRecord
  TOTAL_ID = 0
  has_many :states
end
