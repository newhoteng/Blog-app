class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # updates the comments_counter for a post
  scope :update_comments_counter, lambda { |post_id|
                                    comments_for_post = where('post_id = ?', post_id)
                                    total_comments = comments_for_post.count
                                    post = comments_for_post.first.post
                                    post.update(comments_counter: total_comments)
                                  }
end
