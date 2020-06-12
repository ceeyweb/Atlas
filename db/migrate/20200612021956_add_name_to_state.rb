class AddNameToState < ActiveRecord::Migration[6.0]
  def change
    add_column :states, :name, :string
  end
end
