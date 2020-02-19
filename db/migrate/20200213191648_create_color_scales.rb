# rubocop:disable Rails/CreateTableWithTimestamps
class CreateColorScales < ActiveRecord::Migration[6.0]
  def change
    create_table :color_scales do |t|
      t.integer :minimum, null: false
      t.integer :maximum, null: false
      t.boolean :positive, null: false, default: true
    end

    add_index :color_scales, %i[minimum maximum positive], unique: true
  end
end
# rubocop:enable Rails/CreateTableWithTimestamps
