class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :likes, as: :likeable

  validates_presence_of :body
  validates_presence_of :user_id
  validates_presence_of :post_id
end
