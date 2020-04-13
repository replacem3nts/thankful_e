class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.belongs_to :location, null: false, foreign_key: true
      t.string :phone

      t.timestamps
    end
  end
end
