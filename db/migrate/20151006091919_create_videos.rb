class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :user_id
      t.integer  :category_id
      t.integer :image_id
      t.string  :s3_remote_url, default: nil
      t.string  :local_remote_url, default: nil
      t.string  :youtube_remote_url, default: nil
      t.string  :thumbnail
      t.string  :name
      t.string  :description
      t.string  :artist
      t.integer  :cached_votes_total,  :default => 0
      t.integer  :cached_votes_score,  :default => 0
      t.integer  :cached_votes_up,  :default => 0
      t.integer  :cached_votes_down,  :default => 0
      t.integer  :cached_weighted_score,  :default => 0
      t.integer  :cached_weighted_total,  :default => 0
      t.float  :cached_weighted_average, :default => 0.0
      t.integer :impressions_count,default: 0

      t.timestamps null: false
    end
  end
end
