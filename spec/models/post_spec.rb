require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(Post.reflect_on_association(:user).macro).to eq(:belongs_to)
      expect(Post.reflect_on_association(:comments).macro).to eq(:has_many)
      expect(Post.reflect_on_association(:likes).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    subject { Post.new(author_id: 1, title: 'Hello', text: 'This is my first post')}

    it 'title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:title]).to include("can't be blank")
    end

    it 'comments_counter should be greater than or equal to zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
      expect(subject.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe '#recent_comments method' do
    let(:user) { create(:user) }
    it 'it returns the last 5 comments of a user' do

      user = User.create(name: 'Harriet', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      post = Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post')
      
      first_comment = Comment.create(user_id: user.id, post_id: post.id, text: 'text')
      second_comment = Comment.create(user_id: user.id, post_id: post.id, text: 'text')
      third_comment = Comment.create(user_id: user.id, post_id: post.id, text: 'text')
      fourth_comment = Comment.create(user_id: user.id, post_id: post.id, text: 'text')
      fifth_comment = Comment.create(user_id: user.id, post_id: post.id, text: 'text')
      sixth_comment = Comment.create(user_id: user.id, post_id: post.id, text: 'text')

      recent_comments = post.recent_comments

      expect(recent_comments).to_not include(first_comment)
    end
  end
end
