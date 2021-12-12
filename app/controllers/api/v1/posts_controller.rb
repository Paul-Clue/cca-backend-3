# class Api::V1:PostsController < ApplicationController
class Api::V1::PostsController < ApiController
  # skip_before_action :authorized, :raise => false
  before_action :authorized

  def index
    @posts = Post.select("id, user_id, content, title").all
    render json: @posts.to_json
  end

  def current_user_posts
    @current_users_posts = Post.select("title, content").where(user_id: current_user.id)
    render json: @current_users_posts.to_json
  end

  # def show
  #   @user = User.select("id, username, email")
  #   render json: @user.to_json
  # end

  def update
    @po = Post.all

    @po.each do |v|
      if v.id == params[:id].to_i
        v.update(post_params)
        # render json: v.to_json
        head :no_content
      end
    end
  end

  def create
    @post = current_user.posts.new(post_params)
    if  @post.save
        # @post.valid?
        # @token = issue_token(@user)
        # render json: { user: @user, jwt: @token }
        render json: {post: @post}
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def destroy
    @pos = Post.all
    @pos.each do |v|
      if v.id == params[:id].to_i
        v.destroy
        head :no_content
      end
    end
  end

  private

  def post_params
    # params.require(:user).permit(:username, :password, :email)
    # params.require.permit(:username, :password, :email)
    params.permit(:content, :title)
  end

  def set_post
    @user = Post.find_by(id: post_params[:id])
  end
end
