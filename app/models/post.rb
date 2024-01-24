class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates_presence_of :user_id, :body

  default_scope { order(created_at: :desc) }

  scope :created_today, -> { where(created_at: Time.current.all_day) }
  scope :edited, -> { where('updated_at > created_at') }
  scope :not_edited, -> { where('updated_at = created_at') }

  def created_today?
    created_at.all_day == Time.current.all_day
  end

  def updated_today?
    updated_at.all_day == Time.current.all_day
  end

  def been_edited?
    created_at != updated_at
  end

  def not_been_edited?
    created_at == updated_at
  end
end
