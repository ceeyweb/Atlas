class UpwardMobilityIndicator < ApplicationRecord
  belongs_to :upward_mobility
  belongs_to :indicator
  has_one :region, through: :upward_mobility
  has_one :state, through: :upward_mobility

  delegate :value, to: :upward_mobility
  delegate :name, to: :state, prefix: true

  scope :where_indicator, -> (query){ joins(:indicator).where(indicators: query).includes(:upward_mobility, :region) }

  def self.scatter_data
    current_scope.group_by(&:region).map do |region, mobility_indicators|
      {
        label: region.description,
        backgroundColor: region.color,
        data: mobility_indicators.map(&:mapped_data)
      }
    end
  end

  def mapped_data
    { x: percentage, y: value, state: state_name }
  end
end
