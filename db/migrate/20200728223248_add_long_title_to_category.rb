class AddLongTitleToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :long_title, :string, null: false, default: ""
  end
end
