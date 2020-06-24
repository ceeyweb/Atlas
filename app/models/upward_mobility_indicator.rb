class UpwardMobilityIndicator < ApplicationRecord
  belongs_to :upward_mobility
  belongs_to :indicator
  has_one :region, through: :upward_mobility
  has_one :state, through: :upward_mobility

  delegate :value, to: :upward_mobility, prefix: true
  delegate :name,  to: :state,           prefix: true
  delegate :slug,  to: :indicator

  def self.where_indicator(query)
    joins(:indicator).
      where(indicators: query).
      includes(:upward_mobility, :region)
  end

  def self.scatter_data
    current_scope.group_by(&:region).map do |region, mobility_indicators|
      {
        label: region.description,
        backgroundColor: region.color,
        data: mobility_indicators.map(&:mapped_data),
      }
    end
  end

  def mapped_data
    { x: value, y: upward_mobility_value, state: state_name }
  end

  def value
    case slug
    when "poblacion-sin-educacion" then (percentage * 100).round(1)
    when "embarazo-juvenil"        then (percentage * 1000).round
    else percentage.round(1)
    end
  end
end
