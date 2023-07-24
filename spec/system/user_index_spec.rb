require 'rails_helper'

RSpec.describe 'User views', type: :feature do
  describe 'content of index page' do
    user = User.first

    before :each do
      visit users_path
    end
    it "should show the user's name" do
      expect(page).to have_content(user.name)
    end
  end

  # describe '#update_likes_counter method' do
  #   it 'it increments the likes_counter of a post' do
  #     user = User.create(name: 'Doe')
  #     post = Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post')

  #     expect(post.likes_counter).to eql 0

  #     Like.create(user_id: user.id, post_id: post.id)
  #     post.reload
  #     expect(post.likes_counter).to eql 1

  #     Like.create(user_id: user.id, post_id: post.id)
  #     post.reload
  #     expect(post.likes_counter).to eql 2
  #   end
  # end
end