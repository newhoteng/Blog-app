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
      #contents
    end

    describe 'clicking on post' do
      #contents
    end
  end
end
