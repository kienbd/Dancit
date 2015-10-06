class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :user_id
      t.integer :image_id
      t.string  :name
      t.string  :description
      t.string  :thumbnail

      t.timestamps null: false
    end
  end
end
