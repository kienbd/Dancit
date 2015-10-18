class CreateFellowships < ActiveRecord::Migration
  def change
    create_table :fellowships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps null: false
    end
    add_index :fellowships, :follower_id
    add_index :fellowships, :followed_id
    add_index :fellowships, [:follower_id, :followed_id], unique: true
  end
end
