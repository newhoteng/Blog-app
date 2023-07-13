class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # updates the comments_counter for a post
  scope :update_comments_counter, lambda { |post|
                                    comments_for_post = where('post_id = ?', post.id)
                                    total_comments = comments_for_post.count
                                    post.update(comments_counter: total_comments)
                                  }
end
