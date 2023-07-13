class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  # Returns the 3 most recent posts for a given user
  def recent_three_posts
    posts.order('created_at Desc').limit(3)
  end
end
