class CreateIndicators < ActiveRecord::Migration[6.0]
  def change
    create_table :indicators do |t|
      t.string :slug, null: false
      t.string :description, null: false
    end
  end
end
