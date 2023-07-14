require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(Comment.reflect_on_association(:user).macro).to eq(:belongs_to)
      expect(Comment.reflect_on_association(:post).macro).to eq(:belongs_to)
    end
  end

  describe '#update_comments_counter method' do
    let(:post) { create(:post) }
    it 'it increments the comments_counter for a post' do
      post = Post.create(author_id: 1, title: 'Hello', text: 'This is my first post', likes_counter: 0, comments_counter: 1)
      Comment.create(user_id: 1, post_id: post.id, text: 'text')
  
      expect(post.comments_counter).to eql 1
    end
  end
end
