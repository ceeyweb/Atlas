module Kpis
  class MobilityPercentage < ApplicationRecord
    belongs_to :gender
    belongs_to :region
    belongs_to :category
    belongs_to :quintile
  end
end
