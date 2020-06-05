class CreateUpwardMobilityIndicators < ActiveRecord::Migration[6.0]
  def change
    create_table :upward_mobility_indicators do |t|
      t.references :upward_mobility, null: false, foreign_key: true, index: true
      t.references :indicator, null: false, foreign_key: true, index: true
      t.float :percentage, null: false
    end
  end
end
