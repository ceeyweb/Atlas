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
  { description: "Norte", color: "#145861" },
  { description: "Norte Occidente", color: "#41939c" },
  { description: "Centro Norte", color: "#959696" },
  { description: "Centro", color: "#cdcbca" },
  { description: "Sur", color: "#f58531" },
].each do |region|
  Region.create_or_find_by!(region)
end

{
  "Norte": [
    { slug: "baja-california", name: "Baja California" },
    { slug: "sonora", name: "Sonora" },
    { slug: "chihuahua", name: "Chihuahua" },
    { slug: "coahuila", name: "Coahuila" },
    { slug: "nuevo-leon", name: "Nuevo león" },
    { slug: "tamaulipas", name: "Tamaulipas" },
  ],
  "Norte Occidente": [
    { slug: "baja-california-sur", name: "Baja California Sur" },
    { slug: "sinaloa", name: "Sinaloa" },
    { slug: "durango", name: "Durango" },
    { slug: "zacatecas", name: "Zacatecas" },
    { slug: "nayarit", name: "Nayarit" },
  ],
  "Centro Norte": [
    { slug: "san-luis-potosi", name: "San Luis Potosí" },
    { slug: "aguascalientes", name: "Aguascalientes" },
    { slug: "jalisco", name: "Jalisco" },
    { slug: "colima", name: "Colima" },
    { slug: "michoacan", name: "Michoacán" },
  ],
  "Centro": [
    { slug: "guanajuato", name: "Guanajuato" },
    { slug: "queretaro", name: "Querétaro" },
    { slug: "hidalgo", name: "Hidalgo" },
    { slug: "estado-de-mexico", name: "Estado de México" },
    { slug: "cmdx", name: "Ciudad de México" },
    { slug: "morelos", name: "Morelos" },
    { slug: "tlaxcala", name: "Tlaxcala" },
    { slug: "puebla", name: "Puebla" },
  ],
  "Sur": [
    { slug: "veracruz", name: "Veracruz" },
    { slug: "guerrero", name: "Guerrero" },
    { slug: "oaxaca", name: "Oaxaca" },
    { slug: "tabasco", name: "Tabasco" },
    { slug: "chiapas", name: "Chiapas" },
    { slug: "campeche", name: "Campeche" },
    { slug: "yucatan", name: "Yucatán" },
    { slug: "quintana-roo", name: "Qintana Roo" },
  ],
}.each do |key, states|
  region = Region.find_by!(description: key)
  states.each { |state| State.create!(**state, region: region) }
end

# Categories
categories = {}

[
  {
    slug: "socioeconomica",
    title: "SOCIOECONÓMICA",
    long_title: "MOVILIDAD SOCIOECONÓMICA",
    description: "mide la relación que existe entre el logro socioeconómico de las personas respecto a la condición socioeconómica de su hogar de origen. A partir de este análisis se ofrece un resultado global sobre la movilidad social que captura: a) nivel educativo; b) bienestar material con base en activos y servicios del hogar y c) nivel de hacinamiento.",
  },
  {
    slug: "educacion",
    title: "EDUCACIÓN",
    long_title: "MOVILIDAD EDUCATIVA",
    description: "mide la relación que existe entre la escolaridad de los padres y el logro educativo de los hijos. La educación es uno de los indicadores que permite inferir el potencial de ingreso permanente de las personas. Además, refleja —aunque no de manera exclusiva— las oportunidades que tendrá la persona desde la infancia hasta la juventud.",
  },
  {
    slug: "salud",
    title: "SALUD",
    long_title: "MOVILIDAD EN SALUD",
    description: "mide la relación que existe entre el logro en salud de los hijos respecto a el logro en salud de sus padres.",
  },
  {
    slug: "ocupacional",
    title: "OCUPACIÓN",
    long_title: "MOVILIDAD OCUPACIONAL",
    description: "identifica la facilidad con la que las personas pueden ascender hasta el estrato ocupacional más alto respecto a la ocupación de sus padres. La ocupación, a diferencia de la educación, no indica el potencial en el mercado laboral de las personas, sino su resultado. Además, refleja las oportunidades que brindan, tanto el entorno, como los mercados laborales mismos.",
  },
].each do |category|
  categories[category[:slug]] = Category.find_or_create_by!(category)
end

# Quintiles & Color scales
[
  {
    slug: "saludpersq1",
    name: "Persistencia quintil I",
    description: "Porcentaje de personas que al igual que sus padres permanecieron en el quintil más bajo del índice de salud.",
    scale: {
      minimum: 42,
      maximum: 71,
      category_one: "42-52",
      category_two: "52-58",
      category_three: "58-71",
      inverted: true,
    },
    category: "salud",
  },
  {
    slug: "saludpersq5",
    name: "Persistencia quintil V",
    description: "Porcentaje de personas que al igual que sus padres permanecieron en el quintil más alto del índice de salud.",
    scale: {
      minimum: 16,
      maximum: 84,
      category_one: "16-41",
      category_two: "41-55",
      category_three: "55-84",
      inverted: true,
    },
    category: "salud",
  },
  {
    slug: "saludmov1a5",
    name: "Movilidad del quintil I a quintil V",
    description: "Porcentaje de personas que nacieron en hogares del quintil I del índice de salud y alcanzaron el quintil V.",
    scale: {
      minimum: 0,
      maximum: 4,
      category_one: "0-2",
      category_two: "2-2",
      category_three: "2-4",
      inverted: false,
    },
    category: "salud",
  },
  {
    slug: "educpersq1",
    name: "Persistencia nivel educativo primaria o menos",
    description: "Porcentaje de personas que al igual que sus padres estudiaron hasta la primaria o menos.",
    scale: {
      minimum: 28,
      maximum: 45,
      category_one: "28-35",
      category_two: "35-39",
      category_three: "39-45",
      inverted: true,
    },
    category: "educacion",
  },
  {
    slug: "educpersq5",
    name: "Persistencia nivel educativo carrera profesional",
    description: "Porcentaje de personas que al igual que su padre cuentan con carrera profesional.",
    scale: {
      minimum: 52,
      maximum: 68,
      category_one: "52-62",
      category_two: "62-66",
      category_three: "66-68",
      inverted: true,
    },
    category: "educacion",
  },
  {
    slug: "educmov1a5",
    name: "Movilidad del nivel educativo más bajo al más alto",
    description: "Porcentaje de personas que cuentan con carrera profesional y cuyos padres tienen primaria o menos.",
    scale: {
      minimum: 7,
      maximum: 11,
      category_one: "7-9",
      category_two: "9-9",
      category_three: "9-11",
      inverted: false,
    },
    category: "educacion",
  },
  {
    slug: "ocuppersq1",
    name: "Persistencia trabajo agrícola",
    description: "Porcentaje de personas que al igual que sus padres tienen un trabajo agrícola.",
    scale: {
      minimum: 8,
      maximum: 30,
      category_one: "8-20",
      category_two: "20-24",
      category_three: "24-30",
      inverted: true,
    },
    category: "ocupacional",
  },
  {
    slug: "ocuppersq5",
    name: "Persistencia trabajo no manual de alta calificación",
    description: "Porcentaje de personas que al igual que sus padres tienen un trabajo no manual de alta calificación.",
    scale: {
      minimum: 23,
      maximum: 39,
      category_one: "23-32",
      category_two: "32-36",
      category_three: "32-39",
      inverted: true,
    },
    category: "ocupacional",
  },
  {
    slug: "ocupmov1a5",
    name: "Movilidad de la ocupación menos calificada a la más calificada",
    description: "Porcentaje de personas que tienen un trabajo no manual de alta calificación y cuyos padres tenían un trabajo agrícola.",
    scale: {
      minimum: 1,
      maximum: 6,
      category_one: "1-3",
      category_two: "3-4",
      category_three: "4-6",
      inverted: false,
    },
    category: "ocupacional",
  },
  {
    slug: "riqpersq1",
    name: "Persistencia quintil I",
    description: "Porcentaje de personas que al igual que sus padres permanecieron en el quintil más bajo del índice socioeconómico.",
    scale: {
      minimum: 23,
      maximum: 67,
      category_one: "23-45",
      category_two: "45-53",
      category_three: "53-67",
      inverted: true,
    },
    category: "socioeconomica",
  },
  {
    slug: "riqpersq5",
    name: "Persistencia quintil V",
    description: "Porcentaje de personas que al igual que sus padres permanecieron en el quintil más alto del índice de socioeconómico.",
    scale: {
      minimum: 45,
      maximum: 66,
      category_one: "45-55",
      category_two: "55-59",
      category_three: "59-66",
      inverted: true,
    },
    category: "socioeconomica",
  },
  {
    slug: "riqmov1a5",
    name: "Movilidad del quintil I a quintil V",
    description: "Porcentaje de personas que nacieron en hogares del quintil I del índice socioeconómico y alcanzaron el quintil V.",
    scale: {
      minimum: 2,
      maximum: 8,
      category_one: "2-3",
      category_two: "3-4",
      category_three: "4-8",
      inverted: false,
    },
    category: "socioeconomica",
  },
].each do |quintile_data|
  category = categories[quintile_data[:category]]
  color_scale = ColorScale.create!(quintile_data[:scale])

  Quintile.create_or_find_by!(slug: quintile_data[:slug]) do |quintile|
    quintile.name = quintile_data[:name]
    quintile.category_id = category.id
    quintile.description = quintile_data[:description]
    quintile.color_scale_id = color_scale.id
  end
end

# Absolute Upward Mobility Indicators
[
  {
    slug: "crecimiento-economico",
    description: "Crecimiento económico por habitante (%), 1990-2016",
    tooltip: "Tasa de crecimiento del Producto Interno por Entidad Federativa (PIBE) per cápita; en términos reales, por ciento anual promedio para 1990-2016. <br><br><b>Fuente</b>: INEGI",
  },
  {
    slug: "hacinamiento-vivienda",
    description: "Hacinamiento en las viviendas, promedio, 1990",
    tooltip: "Número de miembros del hogar por cada cuarto en la vivienda; promedio por entidad federativa en 1990. <br><br><b>Fuente</b>: Censo General de Población y Vivienda 1990.",
  },
  {
    slug: "poblacion-sin-educacion",
    description: "Población sin educación primaria completa (%), 1990",
    tooltip: "Porcentaje de la población de la entidad federativa que no completó la educación primaria en 1990. <br><br><b>Fuente</b>: Censo General de Población y Vivienda 1990.",
  },
  {
    slug: "embarazo-juvenil",
    description: "Tasa de embarazo juvenil, 15-19 años (por cada mil), 1990",
    tooltip: "Número de mujeres entre 15 y 19 años que están embarazadas, por cada mil mujeres en ese rango de edad en 1990. <br><br><b>Fuente</b>: Censo General de Población y Vivienda 1990.",
  },
].each { |indicator| Indicator.create!(indicator) }
# rubocop:enable Layout/LineLength
