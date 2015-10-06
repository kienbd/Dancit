class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :user_id
      t.integer :image_id
      t.string :remote_url
      t.string :thumbnail
      t.string :name
      t.string :description
      t.string :artist

      t.timestamps null: false
    end
  end
end
