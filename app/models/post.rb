class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable

  validates_presence_of :user_id, :body

  default_scope { order(created_at: :desc) }

  scope :created_today, -> { where(created_at: Time.current.all_day) }

  def created_today?
    created_at.all_day == Time.current.all_day
  end
end
