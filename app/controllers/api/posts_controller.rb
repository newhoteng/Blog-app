class Api::PostsController < ApplicationController
  load_and_authorize_resource except: %i[index show]

  # GET http://localhost/api/users/:user_id/posts
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author]).where(author_id: params[:user_id])

    if @posts
      # render json: @posts.to_json, status: :ok
      render json: @posts.to_json(only: [:id, :title, :text, :comments_counter, :likes_counter])
    else
      render json: { status: 'Error', errors: @posts.errors }
    end
  end
end
