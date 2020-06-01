class AddCategoryOneToColorScale < ActiveRecord::Migration[6.0]
  def change
    add_column :color_scales, :category_one, :string
  end
end
