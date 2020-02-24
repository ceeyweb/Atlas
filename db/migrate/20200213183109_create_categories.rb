class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :slug, null: false, index: { unique: true }
      t.string :description, null: false
    end
  end
end
