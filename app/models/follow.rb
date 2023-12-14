class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :followee_id }
  validates :followee_id, uniqueness: { scope: :follower_id }

  validate :follower_is_not_followee

  def follower_is_not_followee
    errors.add(:follower, 'cannot follow themselves') if follower == followee
  end
end
