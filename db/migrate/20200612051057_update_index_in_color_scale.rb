class UpdateIndexInColorScale < ActiveRecord::Migration[6.0]
  def change
    # Recreating the index again in order to remove the unique constraint
    remove_index :color_scales, %i[minimum maximum]
    add_index :color_scales, %i[minimum maximum]
  end
end
