require 'rails_helper'

RSpec.describe 'Post index page', type: :feature do

  user = User.create(name: 'Harriet', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  commenter = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Ghana.')
  first_post = Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post')
  Post.create(author_id: user.id, title: 'Hello', text: 'This is my second post')
  Post.create(author_id: user.id, title: 'Hello', text: 'This is my third post')
  comment = Comment.create(user_id: commenter.id, post_id: first_post.id, text: 'comment')
  Comment.create(user_id: commenter.id, post_id: first_post.id, text: 'another comment')

  before :each do
    visit user_posts_path(user)
  end
  describe "page's content" do
    it "should see the user's pic" do
      expect(page).to have_css("img[src='#{user.photo}']")
    end

    it "should see the user's name" do
      expect(page).to have_content user.name
    end

    it 'should see the number of posts' do
      expect(page).to have_content("Number of posts: #{user.posts.count}")
    end

    it "should see the post's title" do
      user.posts.each do |post|
        expect(page).to have_content post.title
      end
    end

    it "should see the post's body" do
      user.posts.each do |post|
        expect(page).to have_content post.text
      end
    end

    it "should see first comments on a post" do
      user.posts.each do |post|
        recent_comments = post.recent_comments
        recent_comments.each do |comment|
          expect(page).to have_content("#{comment.author.name}: #{comment.text}")
        end
      end
    end

    it "should see how many comments a post has" do
      user.posts.each do |post|
        expect(page).to have_content("Comments: #{post.comments.count}")
      end
    end

    it "should see how many likes a post has" do
      user.posts.each do |post|
        expect(page).to have_content("Likes: #{post.likes.count}")
      end
    end

    # modify
    # it "should see pagination" do
    #   user_posts.each do |post|
    #     expect(page).to have_content("Likes: #{post.likes.count}")
    #   end
    # end
  end

  describe 'clicking on post' do
    it "redirects to posts show page" do
      click_link(:href => user_post_path(user, first_post))
      expect(page).to have_current_path(user_post_path(user, first_post))
    end
  end
end
