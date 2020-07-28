class Quintile < ApplicationRecord
  TOOLTIPS = {
    socioeconomica: "Se genera un índice socioeconómico para cada generación
      con base en el análisis de componentes principales. Este índice considera
      las variables de nivel educativo, quintiles del índice de riqueza y
      hacinamiento en el hogar. Posteriormente, se divide a la población en
      cinco grupos socioeconómicos (quintiles), que van del de menor (quintil I)
      al de mayor estatus (quintil V). Cada grupo o quintil corresponde al 20%
      de la población según el índice socioeconómico para cada generación.",
    educacion: "Se consideran cuatro categorías educativas para ambas
      generaciones: a) primaria completa o menos (que incluye a la población
      sin estudios), b) secundaria completa, c) preparatoria completa y d)
      licenciatura o posgrado.",
    ocupacional: "Se consideran seis categorías ocupacionales para ambas
      generaciones. En particular, la categoría de trabajo agrícola incluye a
      asalariados y pequeños propietarios. Mientras que las ocupaciones no
      manuales de alta calificación incluyen altos directivos, grandes
      empleadores, u ocupaciones que requieran una carrera profesional.",
  }.freeze

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
      tooltip: TOOLTIPS[category.slug.to_sym],
      category: {
        title: category.title,
        long_title: category.long_title,
        description: category.description,
      },
    }
  end
end
