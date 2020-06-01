class RemovePositiveFromColorScale < ActiveRecord::Migration[6.0]
  def change
    remove_column :color_scales, :positive
  end
end
