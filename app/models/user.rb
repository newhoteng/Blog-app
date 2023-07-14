class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  # Returns the 3 most recent posts for a given user
  def recent_three_posts
    posts.order('created_at Desc').limit(3)
  end
end
