class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow',
                            dependent: :destroy, inverse_of: :follower
  has_many :followees, through: :followed_users, source: :followee

  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow',
                             dependent: :destroy, inverse_of: :followee
  has_many :followers, through: :following_users, source: :follower

  has_many :follow_requests, foreign_key: :followee_id

  validates_presence_of :name, :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def follow(other_user)
    followed_users.create(followee_id: other_user.id)
  end

  def unfollow(other_user)
    followed_users.find_by(followee_id: other_user.id)&.destroy
  end

  def following?(other_user)
    followees.include?(other_user)
  end

  def request_to_follow(other_user)
    followee = User.find(other_user.id)

    FollowRequest.create(follower_id: id, followee_id: followee.id)
  end
end
