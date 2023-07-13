class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # updates the likes_counter for a post
  scope :update_likes_counter, lambda { |post|
                                 likes_for_post = where('post_id = ?', post.id)
                                 total_likes = likes_for_post.count
                                 post.update(likes_counter: total_likes)
                               }
end
