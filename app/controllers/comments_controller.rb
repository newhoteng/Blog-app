class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = @user
    if @comment.save
      flash[:success] = 'Comment created successfully'
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:errors] = 'Error: Comment could not be saved'
      render :new
    end
  end

  def destroy
    # @user = User.find(params[:user_id])
    # @post = Post.find(params[:post_id])
    # @comment = Comment.find(params[:id])
    # @comment.destroy
    render json: params
    # redirect_to lessons_path
    # user_post_comment DELETE /users/:user_id/posts/:post_id/comments/:id(.:format)                                             comments#destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
