class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.integer :target_id
      t.string :type

      t.timestamps null: false
    end

  end
end
