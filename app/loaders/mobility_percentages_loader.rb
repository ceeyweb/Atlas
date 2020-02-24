require "csv"

class MobilityPercentagesLoader
  MODEL = Kpis::MobilityPercentage

  GENDERS = Gender.all.each_with_object({}) do |gender, result|
    result[gender.description] = gender.id
  end

  REGIONS = Region.all.each_with_object({}) do |region, result|
    result[region.description] = region.id
  end

  QUINTILES = Quintile.all.each_with_object({}) do |quintile, result|
    result[quintile.slug] = [quintile.category_id, quintile.id]
  end

  def self.load
    new.load
  end

  def initialize
    @file = Rails.root.join("db", "data", "#{MODEL.table_name}.csv")
  end

  def load
    MODEL.delete_all
    MODEL.connection.execute(insert)

    true
  end

  private

  attr_reader :file

  def insert
    <<~SQL.squish
      INSERT INTO `#{MODEL.table_name}`
        (`gender_id`, `region_id`, `category_id`, `quintile_id`, `percentage`)
      VALUES #{values.join(', ')}
    SQL
  end

  def values
    CSV.foreach(file, headers: true).map do |row|
      <<~VALUES.squish
        (#{GENDERS[row[0]]},
         #{REGIONS[row[1]]},
         #{QUINTILES[row[2]][0]},
         #{QUINTILES[row[2]][1]},
         #{row[3]})
      VALUES
    end
  end
end
