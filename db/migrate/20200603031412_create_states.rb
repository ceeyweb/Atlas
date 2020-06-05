 class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.string :slug, null: false
      t.references :region, null: false, foreign_key: true, index: true
    end
  end
end
