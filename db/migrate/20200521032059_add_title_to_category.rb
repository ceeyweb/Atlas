class AddTitleToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :title, :string
  end
end
