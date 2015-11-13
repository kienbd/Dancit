class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter,:facebook, :google_oauth2]

  #Relationships
  has_many :courses
  has_many :videos
  has_many :favourites
  has_many :favourite_videos, -> {where type: "video"},class_name: Favourite
  has_many :favourite_courses, -> {where type: "course"},class_name: Favourite

  #Fellowships
  has_many :active_fellowships, class_name:  Fellowship,
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
  has_many :passive_fellowships, class_name:  Fellowship,
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followings, through: :active_fellowships,  source: :followed
  has_many :followers, through: :passive_fellowships, source: :follower

  # vote and like
  acts_as_voter

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_create do |user|
      # user.send("#{auth.provider[0]}_uid") = auth.uid
      user.email = auth.info.email
      if auth.info.name
        user.username = auth.info.name   # assuming the user model has a name
      end
      if auth.info.image
        user.avatar  = auth.info.image + (auth.provider == "facebook" ? "?type=large" : "")  # assuming the user model has an image
      end
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token(12)
    end
    user.update_attributes({"#{auth.provider[0]}_uid".to_sym => auth.uid}) \
      if user.send("#{auth.provider[0]}_uid").blank?
    # update token
    user.update_attributes({"#{auth.provider[0]}_access_token".to_sym => auth.credentials.token})
    user
  end


  def follow followed_id
    fellow = Fellowship.create(follower_id: self.id,followed_id: followed_id)
    fellow.save
  end

  def unfollow followed_id
    Fellowship.where(follower_id: self.id,followed_id: followed_id).delete_all
  end

  def following?(other_user)
    followings.include?(other_user)
  end

end
