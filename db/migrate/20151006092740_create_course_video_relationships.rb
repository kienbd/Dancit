class CreateCourseVideoRelationships < ActiveRecord::Migration
  def change
    create_table :course_video_relationships do |t|
      t.integer :course_id
      t.integer :video_id

      t.timestamps null: false
    end
  end
end
