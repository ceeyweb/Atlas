# rubocop:disable Layout/LineLength
class ApplicationRecord
  def readonly?
    false
  end
end

# Genders
Gender.create_or_find_by(id: 0) do |gender|
  gender.description = "Nacional"
end

%w[Mujer Hombre].each do |gender|
  Gender.create_or_find_by!(description: gender)
end

# Regions
Region.create_or_find_by(id: 0) do |gender|
  gender.description = "Total"
end

[
  { description: "Norte", color: '#145861' },
  { description: "Norte Occidente", color: '#41939c' },
  { description: "Centro Norte", color: '#959696' },
  { description: "Centro", color: '#cdcbca' },
  { description: "Sur", color: '#f58531' }
].each do |region|
  Region.create_or_find_by!(region)
end

{
  "Norte": [
    { slug: "baja-california", name: 'Baja California' },
    { slug: "sonora", name: 'Sonora' },
    { slug: "chihuahua", name: 'Chihuahua' },
    { slug: "coahuila", name: 'Coahuila' },
    { slug: "nuevo-leon", name: 'Nuevo león' },
    { slug: "tamaulipas", name: 'Tamaulipas' }
  ],
  "Norte Occidente": [
    { slug: "baja-california-sur", name: 'Baja California Sur' },
    { slug: "sinaloa", name: 'Sinaloa' },
    { slug: "durango", name: 'Durango' },
    { slug: "zacatecas", name: 'Zacatecas' },
    { slug: "nayarit", name: 'Nayarit' }
  ],
  "Centro Norte": [
    { slug: "san-luis-potosi", name: 'San Luis Potosí' },
    { slug: "aguascalientes", name: 'Aguascalientes' },
    { slug: "jalisco", name: 'Jalisco' },
    { slug: "colima", name: 'Colima' },
    { slug: "michoacan", name: 'Michoacán' }
  ],
  "Centro": [
    { slug: "guanajuato", name: 'Guanajuato' },
    { slug: "queretaro", name: 'Querétaro' },
    { slug: "hidalgo", name: 'Hidalgo' },
    { slug: "estado-de-mexico", name: 'Estado de México' },
    { slug: "cmdx", name: 'Ciudad de México' },
    { slug: "morelos", name: 'Morelos' },
    { slug: "tlaxcala", name: 'Tlaxcala' },
    { slug: "puebla", name: 'Puebla' }
  ],
  "Sur": [
    { slug: "veracruz", name: 'Veracruz' },
    { slug: "guerrero", name: 'Guerrero' },
    { slug: "oaxaca", name: 'Oaxaca' },
    { slug: "tabasco", name: 'Tabasco' },
    { slug: "chiapas", name: 'Chiapas' },
    { slug: "campeche", name: 'Campeche' },
    { slug: "yucatan", name: 'Yucatán' },
    { slug: "quintana-roo", name: 'Qintana Roo' }
  ]
}.each do |key, states|
  region = Region.find_by!(description: key)
  states.each{ |state| State.create!(**state, region: region) }
end


# Categories
categories = {}

[
  {
    slug: 'socioeconomica',
    title: 'SOCIOECONOMICA',
    description: 'Resume el bienestar material acumulado de las personas con relación al de su hogar de origen. El nivel de riqueza refleja qué tanto los hogares pueden absorber choques adversos o generar planes de inversión a futuro.'
  },
  {
    slug: 'educacion',
    title: 'EDUCACION',
    description: 'Mide la relación que existe entre la escolaridad de los padres y el logro educativo de los hijos. La educación refleja el potencial en el mercado laboral de las personas.'
  },
  {
    slug: 'salud',
    title: 'SALUD',
    description: 'La movilidad intergeneracional en salud es la relación que existe entre el logro en salud de los hijos respecto al logro en salud de sus padres.',
  },
  {
    slug: 'ocupacional',
    title: 'OCUPACION',
    description: 'Identifica la facilidad con la que los hijos pueden ascender hasta el estrato más alto respecto a la ocupación de sus padres. La ocupación indica la realización socioeconómica de las personas.'
  },
].each do |category|
  categories[category[:slug]] = Category.find_or_create_by!(category)
end

# Quintiles & Color scales
[
  {
    slug: "saludpersq1",
    name: "Persistencia quintil I",
    description: "al igual que sus padres permanecen al quintil más bajo de salud",
    scale: {
      minimum: 45,
      maximum: 64,
      category_one: "45-53",
      category_two: "53-57",
      category_three: "57-64"
    },
    category: "salud",
  },
  {
    slug: "saludpersq5",
    name: "Persistencia quintil V",
    description: "al igual que sus padres permanecen al quintil más alto de salud",
    scale: {
      minimum: 35,
      maximum: 54,
      category_one: "35-46",
      category_two: "46-50",
      category_three: "50-54"
    },
    category: "salud",
  },
  {
    slug: "saludmov1a5",
    name: "Movilidad del quintil I a quintil V",
    description: "nacieron en hogares del quintil I de salud y alcanzaron el quintil V",
    scale: {
      minimum: 1,
      maximum: 3,
      category_one: "1-2",
      category_two: "2-2",
      category_three: "2-3"
    },
    category: "salud",
  },
  {
    slug: "educpersq1",
    name: "Persistencia nivel educativo sin estudios",
    description: "al igual que su padre continúa sin estudios",
    scale: {
      minimum: 2,
      maximum: 8,
      category_one: "2-3",
      category_two: "3-5",
      category_three: "5-8"
    },
    category: "educacion",
  },
  {
    slug: "educpersq5",
    name: "Persistencia nivel educativo carrera profesional",
    description: "al igual que su padre cuentan con carrera profesional",
    scale: {
      minimum: 53,
      maximum: 68,
      category_one: "53-63",
      category_two: "63-66",
      category_three: "66-68"
    },
    category: "educacion",
  },
  {
    slug: "educmov1a5",
    name: "Movilidad del nivel educativo más bajo al más alto",
    description: "cuentan con carrera profesional y que su padre no cuenta con estudios",
    scale: {
      minimum: 8,
      maximum: 11,
      category_one: "8-9",
      category_two: "9-9",
      category_three: "9-11"
    },
    category: "educacion",
  },
  {
    slug: "ocuppersq1",
    name: "Persistencia trabajo agrícola",
    description: "al igual que su padre tiene un trabajo agrícola",
    scale: {
      minimum: 18,
      maximum: 25,
      category_one: "18-21",
      category_two: "21-23",
      category_three: "23-25"
    },
    category: "ocupacional",
  },
  {
    slug: "ocuppersq5",
    name: "Persistencia trabajo no manual de alta calificación",
    description: "al igual que su padre cuentan con trabajo no manual de alta calificación",
    scale: {
      minimum: 24,
      maximum: 39,
      category_one: "24-33",
      category_two: "33-36",
      category_three: "36-39"
    },
    category: "ocupacional",
  },
  {
    slug: "ocupmov1a5",
    name: "Movilidad de la ocupación menos calificada a la más calificada",
    description: "cuentan con trabajo no manual de alta calificación y que su padre contaba con trabajo agrícola",
    scale: {
      minimum: 2,
      maximum: 6,
      category_one: "2-3",
      category_two: "3-3",
      category_three: "3-6"
    },
    category: "ocupacional",
  },
  {
    slug: "riqpersq1",
    name: "Persistencia quintil I",
    description: "al igual que sus padres permanecen al quintil más bajo del índice de riqueza",
    scale: {
      minimum: 25,
      maximum: 62,
      category_one: "25-43",
      category_two: "43-51",
      category_three: "51-62"
    },
    category: "socioeconomica",
  },
  {
    slug: "riqpersq5",
    name: "Persistencia quintil V",
    description: "al igual que sus padres permanecen al quintil más alto del índice de riqueza",
    scale: {
      minimum: 41,
      maximum: 62,
      category_one: "41-52",
      category_two: "52-56",
      category_three: "56-62"
    },
    category: "socioeconomica",
  },
  {
    slug: "riqmov1a5",
    name: "Movilidad del quintil I a quintil V",
    description: "nacieron en hogares del quintil I del índice de riqueza y alcanzaron el quintil V",
    scale: {
      minimum: 2,
      maximum: 6,
      category_one: "2-3",
      category_two: "3-3",
      category_three: "3-6"
    },
    category: "socioeconomica",
  },
].each do |quintile_data|
  category = categories[quintile_data[:category]]
  color_scale = ColorScale.create!(quintile_data[:scale])

  Quintile.create_or_find_by!(slug: quintile_data[:slug]) do |quintile|
    quintile.name = quintile_data[:name]
    quintile.category_id = category.id
    quintile.description = "Porcentaje de personas que #{quintile_data[:description]}."
    quintile.color_scale_id = color_scale.id
  end
end

# Absolute Upward Mobility Indicators
[
  {
    slug: "crecimiento-economico",
    description: "Tasa de crecimiento económico, promedio 1990-2016 (%)"
  },
  {
    slug: "hacinamiento-vivienda",
    description: "Hacinamiento en vivienda (número de personas/número de cuartos)"
  },
  {
    slug: "poblacion-sin-educacion",
    description: "Población sin educación o con primaria incompleta (%)"
  },
  {
    slug: "embarazo-juvenil",
    description: "Tasa de embarazo juvenil, 15-19 años (%)"
  }
].each {|indicator| Indicator.create!(indicator) }
# rubocop:enable Layout/LineLength
