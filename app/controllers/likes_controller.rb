class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new(user_id: @user.id, post_id: @post.id)
    return unless @like.save

    redirect_to user_post_path(@user.id, @post)
  end
end
