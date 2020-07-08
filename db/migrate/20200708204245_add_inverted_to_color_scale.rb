class AddInvertedToColorScale < ActiveRecord::Migration[6.0]
  def change
    add_column :color_scales, :inverted, :boolean, null: false, default: true
  end
end
