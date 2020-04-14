class RemoveCityFromLocations < ActiveRecord::Migration[6.0]
  def change
    remove_column :locations, :city, :string
    add_column :locations, :abbrev, :string
  end
end
