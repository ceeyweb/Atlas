class MobilityController < ApplicationController
  def index; end

  def show
    quintile  = Quintile.find_by(slug: params["slug"])
    gender_id = params["gender"] || 0

    kpis = Kpis::MobilityPercentage.where(quintile_id: quintile.id)

    kpis_region = kpis.where(gender_id: gender_id).where.not(region_id: 0)
    kpis_gender = kpis.where(region_id: 0)

    min = quintile.color_scale.minimum
    max = quintile.color_scale.maximum

    size = (max - min) / 12.to_f

    ranges = (1..12).map do |i|
      low = (min + (size * (i - 1))).round(2)
      high = (min + ((size * i) - 0.01)).round(2)

      low..high
    end

    unless quintile.color_scale.positive?
      ranges.reverse!
      direction = "left"
    end

    regions = kpis_region.map do |kpi|
      { description: kpi.region.description, value: kpi.percentage }
    end

    if quintile.color_scale.positive?
      best = 0
      worst = 11
    else
      best = 11
      worst = 0
    end

    genders = kpis_gender.map do |kpi|
      if kpis.where(gender_id: kpi.gender_id).where.not(region_id: 0).present?
        url = mobility_path(slug: quintile.slug, gender: kpi.gender_id)
      end
      color_index = if kpi.percentage < min
                      best
                    elsif kpi.percentage >= max
                      worst
                    else
                      ranges.each_index.detect do |i|
                        ranges[i].cover?(kpi.percentage)
                      end
                    end

      {
        description: kpi.gender.description,
        value: kpi.percentage,
        color_index: color_index + 1,
        url: url,
      }
    end

    data = {
      regions: regions,
      genders: genders,
      title: quintile.name,
      description: quintile.description,
      color_scale: { min: min, max: max, direction: direction || "right" },
    }

    render json: data
  end
end
