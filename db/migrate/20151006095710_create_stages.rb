class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.string :name
      t.integer :video_id
      t.integer :image_id
      t.string  :start_at
      t.string  :end_at
      t.string  :thumbnail

      t.timestamps null: false
    end
  end
end
