# rubocop:disable Rails/CreateTableWithTimestamps
class CreateQuintiles < ActiveRecord::Migration[6.0]
  def change
    create_table :quintiles do |t|
      t.string :slug, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :description, null: false
      t.references :category, null: false, foreign_key: true
      t.references :color_scale, null: false, foreign_key: true
    end

    add_index :quintiles, %i[name category_id], unique: true
  end
end
# rubocop:enable Rails/CreateTableWithTimestamps
