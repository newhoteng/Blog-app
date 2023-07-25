require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  # user_post GET    /users/:user_id/posts/:id(.:format)  posts#show
  # user_posts GET    /users/:user_id/posts(.:format)     posts#index

  describe "index page's content and features" do
    user = User.first
    user_posts = user.posts
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
        user_posts.each do |post|
          expect(page).to have_content post.title
        end
      end

      it "should see the post's body" do
        user_posts.each do |post|
          expect(page).to have_content post.text
        end
      end
      # modify
      it "should see first comments on a post" do
        user_posts.each do |post|
          comment_on_post = post.comments
          comment_on_post.each do |comment|
            expect(page).to have_content("#{comment.author}: #{comment.text}")
          end
        end
      end

      it "should see how many comments a post has" do
        user_posts.each do |post|
          expect(page).to have_content("Comments: #{post.comments.count}")
        end
      end

      it "should see how many likes a post has" do
        user_posts.each do |post|
          expect(page).to have_content("Likes: #{post.likes.count}")
        end
      end

      # modify
      it "should see pagination" do
        user_posts.each do |post|
          expect(page).to have_content("Likes: #{post.likes.count}")
        end
      end
    end

    describe 'clicking on post' do
      #contents
    end
  end
end
