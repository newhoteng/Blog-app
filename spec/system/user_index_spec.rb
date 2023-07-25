require 'rails_helper'

RSpec.describe 'User', type: :feature do
  describe "index page's content and features" do
    users = User.all
    before :each do
      visit users_path
    end
    describe "page's content" do
      it "should show the user's name" do
        users.each { |user| expect(page).to have_content user.name }
      end

      it "should show the user's pic" do
        users.each { |user| expect(page).to have_css("img[src='#{user.photo}']") }
      end

      it 'should display the number of posts' do
        users.each { |user| expect(page).to have_content("Number of posts: #{user.posts.count}") }
      end
    end

    describe 'clicking on user link feature' do
      it 'redirects to show page' do
        @user = User.first
        click_link(:href => user_path(@user))
        expect(page).to have_current_path(user_path(@user))
      end
    end
  end

  describe "show page's content and features" do
    user = User.first
    recent_posts = user.recent_three_posts
    before :each do
      visit user_path(user)
    end
    describe "page's content" do
      it "should show the user's pic" do
        expect(page).to have_css("img[src='#{user.photo}']") 
      end

      it "should show the user's name" do
        expect(page).to have_content user.name
      end

      it 'should display the number of posts' do
        expect(page).to have_content("Number of posts: #{user.posts.count}")
      end

      it "should show the user's bio" do
        expect(page).to have_content("#{user.bio}")
      end

      it "should show the user's three posts" do
        recent_posts.each { |post| expect(page).to have_content("#{post.text}") }
      end

      it "should see a link to 'See all posts'" do
        expect(page).to have_link('See all posts')
      end
    end

    describe 'interactions on page' do
      it "redirects to post's show page when post is clicked" do
        recent_posts.each do |post|
          click_link(:href => user_post_path(user, post))
          expect(page).to have_current_path(user_post_path(user, post))
        end
      end

      it "redirects to post's index page when 'See all post' clicked" do
        click_link('See all post')
        expect(page).to have_current_path(user_posts_path(user))
      end
    end
  end
end