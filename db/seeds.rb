# rubocop:disable Layout/LineLength
class ApplicationRecord
  def readonly?
    false
  end
end

# Genders
Gender.create_or_find_by(id: 0) do |gender|
  gender.description = "Total"
end

%w[Mujer Hombre].each do |gender|
  Gender.create_or_find_by!(description: gender)
end

# Regions
Region.create_or_find_by(id: 0) do |gender|
  gender.description = "Nacional"
end

["Norte", "Norte Occidente", "Centro Norte", "Centro", "Sur"].each do |region|
  Region.create_or_find_by!(description: region)
end

# Categories
categories = {}

%w[salud educación ocupacional socioeconomica].each do |text|
  slug = I18n.transliterate(text)

  categories[slug] = Category.create_or_find_by!(slug: slug) do |category|
    category.description = "Movilidad intergeneracional en #{slug}"
  end
end

# Quintiles & Color scales
[
  {
    slug: "saludpersq1",
    name: "Persistencia quintil I",
    description: "al igual que sus padres permanecen al quintil más bajo de salud",
    scale: [30, 70, true],
    category: "salud",
  },
  {
    slug: "saludpersq5",
    name: "Persistencia quintil V",
    description: "al igual que sus padres permanecen al quintil más alto de salud",
    scale: [30, 70, true],
    category: "salud",
  },
  {
    slug: "saludmov1a5",
    name: "Movilidad del quintil I a quintil V",
    description: "nacieron en hogares del quintil I de salud y alcanzaron el quintil V",
    scale: [0, 4, false],
    category: "salud",
  },
  {
    slug: "educpersq1",
    name: "Persistencia nivel educativo sin estudios",
    description: "al igual que su padre continúa sin estudios",
    scale: [1, 9, true],
    category: "educacion",
  },
  {
    slug: "educpersq5",
    name: "Persistencia nivel educativo carrera profesional",
    description: "al igual que su padre cuentan con carrera profesional",
    scale: [50, 70, false],
    category: "educacion",
  },
  {
    slug: "educmov1a5",
    name: "Movilidad del nivel educativo más bajo al más alto",
    description: "cuentan con carrera profesional y que su padre no cuenta con estudios",
    scale: [6, 10, false],
    category: "educacion",
  },
  {
    slug: "ocuppersq1",
    name: "Persistencia trabajo agrícola",
    description: "al igual que su padre tiene un trabajo agrícola",
    scale: [16, 26, true],
    category: "ocupacional",
  },
  {
    slug: "ocuppersq5",
    name: "Persistencia trabajo no manual de alta calificación",
    description: "al igual que su padre cuentan con trabajo no manual de alta calificación",
    scale: [20, 35, false],
    category: "ocupacional",
  },
  {
    slug: "ocupmov1a5",
    name: "Movilidad de la ocupación menos calificada a la más calificada",
    description: "cuentan con trabajo no manual de alta calificación y que su padre contaba con trabajo agrícola",
    scale: [1, 9, false],
    category: "ocupacional",
  },
  {
    slug: "riqpersq1",
    name: "Persistencia quintil I",
    description: "al igual que sus padres permanecen al quintil más bajo del índice de riqueza",
    scale: [20, 70, true],
    category: "socioeconomica",
  },
  {
    slug: "riqpersq5",
    name: "Persistencia quintil V",
    description: "al igual que sus padres permanecen al quintil más alto del índice de riqueza",
    scale: [20, 70, false],
    category: "socioeconomica",
  },
  {
    slug: "riqmov1a5",
    name: "Movilidad del quintil I a quintil V",
    description: "nacieron en hogares del quintil I del índice de riqueza y alcanzaron el quintil V",
    scale: [2, 6, false],
    category: "socioeconomica",
  },
].each do |quintile_data|
  category = categories[quintile_data[:category]]
  color_scale = ColorScale.create_or_find_by!(
    minimum: quintile_data[:scale][0],
    maximum: quintile_data[:scale][1],
    positive: quintile_data[:scale][2],
  )

  Quintile.create_or_find_by!(slug: quintile_data[:slug]) do |quintile|
    quintile.name = quintile_data[:name]
    quintile.category_id = category.id
    quintile.description = "Porcentaje de personas que #{quintile_data[:description]}."
    quintile.color_scale_id = color_scale.id
  end
end
# rubocop:enable Layout/LineLength
