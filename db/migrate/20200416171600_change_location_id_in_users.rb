class ChangeLocationIdInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :location_id, :bigint, :null => true 
  end
end
