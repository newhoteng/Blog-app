class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  # Updates the posts counter for a user
  scope :update_posts_counter, lambda { |user_id|
                                 posts_for_user = where('author_id = ?', user_id)
                                 total_posts = posts_for_user.count
                                 user = posts_for_user.first.user
                                 user.update(posts_counter: total_posts)
                               }

  # Returns the 5 most recent comments for a given post
  scope :recent_five_comments, ->(post_id) { find(post_id).comments.order('comments.created_at DESC').limit(5) }
end
