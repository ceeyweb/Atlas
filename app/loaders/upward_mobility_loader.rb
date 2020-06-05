require 'csv'

class ApplicationRecord
  def readonly?
    false
  end
end

class UpwardMobilityLoader
  MODEL = UpwardMobility
  INDICATORS = Indicator.order(:id)
  ROW_INDICATOR_INDEX = 3

  def initialize
    validate_indicators
    @file =  Rails.root.join("db", "data", "#{MODEL.table_name}.csv")
  end

  def self.load
    new.load_data
  end

  def load_data
    ActiveRecord::Base.transaction do
      MODEL.delete_all
      CSV.foreach(file, headers: true) do |row|
        state = State.find_by!(slug: row[1])
        upward_mobility = UpwardMobility.create!(state_id: state.id, value: row[2])

        INDICATORS.each_with_index do |indicator, i|
          index = ROW_INDICATOR_INDEX + i
          UpwardMobilityIndicator.create!(
            upward_mobility: upward_mobility,
            indicator: INDICATORS[i],
            percentage: row[index]
          )
        end
      end
    end
  end

  private

  attr_reader :file

  def validate_indicators
    raise "Asegúrate de que los indicadores esten cargados correctamente en la BD" if INDICATORS.count != 4
  end
end
