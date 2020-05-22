class Quintile < ApplicationRecord
  belongs_to :category
  belongs_to :color_scale

  has_many :kpis, class_name: "Kpis::MobilityPercentage", dependent: :destroy

  def kpis_by_gender
    kpis.genders.map do |kpi|
      kpi.to_h(except: :region)
    end
  end

  def kpis_by_region(gender_id = 0)
    kpis.regions.gender(gender_id).map do |kpi|
      kpi.to_h(except: %i[gender url])
    end
  end

  def to_h(gender_id = nil)
    {
      genders: kpis_by_gender,
      regions: kpis_by_region(gender_id || 0),
      title: name,
      description: description,
      color_scale: color_scale.to_h,
      category: {
        title: category.title,
        description: category.description
      }
    }
  end
end
