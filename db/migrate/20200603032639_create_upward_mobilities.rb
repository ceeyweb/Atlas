class CreateUpwardMobilities < ActiveRecord::Migration[6.0]
  def change
    create_table :upward_mobilities do |t|
      t.references :state, null: false, foreign_key: true, index: true
      t.float :value, null: false
    end
  end
end
