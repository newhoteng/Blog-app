class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_comments_counter

  # updates the comments_counter for a post
  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
