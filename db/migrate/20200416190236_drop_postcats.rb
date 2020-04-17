class DropPostcats < ActiveRecord::Migration[6.0]
  def change
    drop_table :postcats
  end
end
