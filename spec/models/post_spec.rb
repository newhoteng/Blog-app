require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it 'should have correct associations' do
      expect(Post.reflect_on_association(:author).macro).to eq(:belongs_to)
      expect(Post.reflect_on_association(:comments).macro).to eq(:has_many)
      expect(Post.reflect_on_association(:likes).macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    user = User.create(name: 'Harriet')
    subject { Post.new(author_id: user.id, title: 'Hello', text: 'This is my first post') }

    before { subject.save }

    it 'title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:title]).to include("can't be blank")
    end

    it 'title should not be more than 250 characters' do
      subject.title = 't' * 251
      expect(subject).to_not be_valid
      expect(subject.errors[:title]).to include('250 characters is the maximun allowed')
    end

    it 'title should be 250 characters or less' do
      subject.title = 't' * 250
      expect(subject).to be_valid
    end

    it 'comments_counter should be greater than or equal to zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
      expect(subject.errors[:comments_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe '#recent_comments method' do
    it 'it returns the last 5 comments of a post' do
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
      expect(recent_comments).to include(sixth_comment, fifth_comment, fourth_comment, third_comment, second_comment)
    end
  end

  describe '#update_posts_counter method' do
    it 'it increments the posts_counter of a user' do
      user = User.create(name: 'Doe', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'Teacher from Mexico.')

      expect(user.posts_counter).to eql 0

      Post.create(author_id: user.id, title: 'Hello', text: 'Text')
      user.reload
      expect(user.posts_counter).to eql 1

      Post.create(author_id: user.id, title: 'MS', text: 'Some text')
      user.reload
      expect(user.posts_counter).to eql 2
    end
  end
end
