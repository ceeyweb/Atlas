class AddTooltipToIndicators < ActiveRecord::Migration[6.0]
  def change
    add_column :indicators, :tooltip, :string
  end
end
