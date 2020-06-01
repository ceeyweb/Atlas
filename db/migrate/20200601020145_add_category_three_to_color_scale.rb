class AddCategoryThreeToColorScale < ActiveRecord::Migration[6.0]
  def change
    add_column :color_scales, :category_three, :string
  end
end
