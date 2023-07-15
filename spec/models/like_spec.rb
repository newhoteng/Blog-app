require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(Like.reflect_on_association(:user).macro).to eq(:belongs_to)
      expect(Like.reflect_on_association(:post).macro).to eq(:belongs_to)
    end
  end

  describe '#update_likes_counter method' do
    it 'it increments the likes_counter of a post' do
      user = User.create(name: 'Doe')
      post = Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post')

      expect(post.likes_counter).to eql 0

      Like.create(user_id: user.id, post_id: post.id)
      post.reload
      expect(post.likes_counter).to eql 1

      Like.create(user_id: user.id, post_id: post.id)
      post.reload
      expect(post.likes_counter).to eql 2
    end
  end
end
