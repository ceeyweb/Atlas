class CreateKpisMobilityPercentages < ActiveRecord::Migration[6.0]
  def change
    create_table :kpis_mobility_percentages, id:false do |t|
      t.float :percentage, null: false
      t.references :gender, null: false, foreign_key: true, index: true
      t.references :region, null: false, foreign_key: true, index: true
      t.references :category, null: false, foreign_key: true, index: true
      t.references :quintile, null: false, foreign_key: true, index: true
    end
  end
end
