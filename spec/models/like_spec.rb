require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(Like.reflect_on_association(:user).macro).to eq(:belongs_to)
      expect(Like.reflect_on_association(:post).macro).to eq(:belongs_to)
    end
  end

  describe '#update_likes_counter method' do
    let(:post) { create(:post) }
    it 'it returns the last 5 comments of a user' do
      post = Post.create(author_id: 1, title: 'Hello', text: 'This is my first post', likes_counter: 1)
      Like.create(user_id: 1, post_id: post.id)

      expect(post.likes_counter).to eql 1
    end
  end
end
