class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author]).where(author_id: params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    if @post.save
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:errors] = 'Invalid post!'
      render :new
    end
  end

  def destroy
    render json: params
    # Post.destroy(params[:id])
    # redirect_to lessons_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

# post_delete DELETE /delete/post/:id(.:format)                                                                        posts#destroy
# comment_delete DELETE /delete/comment/:id(.:format)                                                                     comments#destroy
