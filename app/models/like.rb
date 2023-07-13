class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # updates the likes_counter for a post
  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
