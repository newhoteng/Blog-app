require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)
      expect(Comment.reflect_on_association(:post).macro).to eq(:belongs_to)
    end
  end

  describe '#update_comments_counter method' do
    it 'it increments the comments_counter for a post' do
      user = User.create(name: 'John')
      post = Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post')

      expect(post.comments_counter).to eql 0

      Comment.create(user_id: user.id, post_id: post.id, text: 'text')
      post.reload
      expect(post.comments_counter).to eql 1

      Comment.create(user_id: user.id, post_id: post.id, text: 'text')
      post.reload
      expect(post.comments_counter).to eql 2
    end
  end
end
