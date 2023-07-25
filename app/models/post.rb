class Post < ApplicationRecord
  paginates_per 3
  
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250, too_long: '%<count>s characters is the maximun allowed' }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  # Updates the posts counter for a user
  def update_posts_counter
    author.increment!(:posts_counter)
  end

  # Returns the 5 most recent comments for a given post
  def recent_comments
    comments.order('created_at Desc').limit(5)
  end
end
