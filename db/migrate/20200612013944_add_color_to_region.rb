class AddColorToRegion < ActiveRecord::Migration[6.0]
  def change
    add_column :regions, :color, :string
  end
end
