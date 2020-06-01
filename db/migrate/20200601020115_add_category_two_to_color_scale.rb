class AddCategoryTwoToColorScale < ActiveRecord::Migration[6.0]
  def change
    add_column :color_scales, :category_two, :string
  end
end
