class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.belongs_to :user, null: false, foreign_key: true
      t.string :content
      t.boolean :private
      t.belongs_to :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
