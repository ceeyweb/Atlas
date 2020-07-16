class ChangeDescriptionTypeInCategory < ActiveRecord::Migration[6.0]
  def change
    change_column :categories, :description, :text
  end
end
