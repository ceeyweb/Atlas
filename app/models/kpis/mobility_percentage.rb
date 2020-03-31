module Kpis
  class MobilityPercentage < ApplicationRecord
    belongs_to :gender
    belongs_to :region
    belongs_to :category
    belongs_to :quintile

    delegate :color_scale, to: :quintile

    scope :regions, ->         { where.not(region_id: Region::TOTAL_ID) }
    scope :genders, ->         { where(region_id: Region::TOTAL_ID) }
    scope :gender,  ->(gender) { where(gender_id: gender) }

    def url
      return unless gender_by_region_available?

      Rails.application.routes.url_helpers.mobility_path(
        slug: quintile.slug,
        gender: gender_id,
      )
    end

    def to_h(except: {})
      {
        gender: gender.description,
        region: region.description.downcase.gsub(" ", "-"),
        value: "%.2f" % percentage,
        color: color_scale.color_for(percentage),
        url: url,
      }.except(except)
    end

    private

    def gender_by_region_available?
      quintile.kpis.regions.gender(gender_id).present?
    end
  end
end
