class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  # Returns the 3 most recent posts for a given user
  scope :recent_three_posts, lambda { |user_id|
                               joins(:posts).where('users.id = ?', user_id).order('posts.created_at DESC').limit(3)
                             }
end
