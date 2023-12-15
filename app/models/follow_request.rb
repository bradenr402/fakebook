class FollowRequest < ApplicationRecord
  enum :status, { pending: 0, accepted: 1, declined: 2 }

  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validates_presence_of :follower_id, :followee_id
  validates :status, inclusion: { in: FollowRequest.statuses.keys }

  def accept!
    update!(status: 'accepted')
    follower = User.find(follower_id)
    followee = User.find(followee_id)

    follower.follow(followee)

    # send notification to follower
  end

  def decline!
    update!(status: 'declined')
  end
end
