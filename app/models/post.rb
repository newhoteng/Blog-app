class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  scope :update_posts_counter, lambda { |user_id|
                                 posts_for_user = where('author_id = ?', user_id)
                                 total_posts = posts_for_user.count
                                 user = posts_for_user.first.user
                                 user.update(posts_counter: total_posts)
                               }
end
