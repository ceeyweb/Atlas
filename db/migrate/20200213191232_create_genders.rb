# rubocop:disable Rails/CreateTableWithTimestamps
class CreateGenders < ActiveRecord::Migration[6.0]
  def change
    create_table :genders do |t|
      t.string :description, null: false, index: { unique: true }
    end
  end
end
# rubocop:enable Rails/CreateTableWithTimestamps
