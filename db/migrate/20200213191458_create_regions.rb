# rubocop:disable Rails/CreateTableWithTimestamps
class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :regions do |t|
      t.string :description, null: false, index: { unique: true }
    end
  end
end
# rubocop:enable Rails/CreateTableWithTimestamps
