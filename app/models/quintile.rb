class Quintile < ApplicationRecord
  CATEGORIES_WITH_TOOLTIP = %w[socioeconomica educacion ocupacion].freeze
  TOOLTIP_URL = "https://ceey.org.mx/contenido/que-hacemos/emovi-pre/".freeze
  TOOLTIP = <<~TOOLTIP.freeze
    Para el análisis regional se considera la región de residencia a los 14
    años de edad. La ESRU-EMOVI 2017 es representativa para mujeres y hombres
    entre 25 y 64 años a nivel nacional, para la CDMX y cinco regiones del
    país.
  TOOLTIP

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
      tooltip: tooltip,
      category: {
        title: category.title,
        description: category.description,
      },
    }
  end

  private

  def tooltip
    if CATEGORIES_WITH_TOOLTIP.include?(category.slug)
      { text: TOOLTIP, url: TOOLTIP_URL }
    end
  end
end
