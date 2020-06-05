class UpwardMobilityIndicator < ApplicationRecord
  belongs_to :upward_mobility
  belongs_to :indicator
  delegate :value, to: :upward_mobility

  scope :where_indicator, -> (query){ joins(:indicator).where(indicators: query).includes(:upward_mobility) }

  def self.scatter_data
    current_scope.map do |mobility_indicator|
      { x: mobility_indicator.percentage, y: mobility_indicator.value }
    end
  end
end
