class Api::V1::MilestonesController < ApiController
  # skip_before_action :authorized, :raise => false
  # before_action :authorized

  def index
    @miles = Milestone.select("id, user_id, completed, title, instructions").all
    render json: @miles.to_json
  end

  def current_user_milestones
    @current_users_milestones = Milestone.select("title, instructions").where(user_id: current_user.id)
    render json: @current_users_milestones.to_json
    # render json: current_user.to_json
  end

  # def show
  #   @user = User.select("id, username, email")
  #   render json: @user.to_json
  # end

  def update
    @mi = Milestone.all

    @mi.each do |v|
      if v.id == params[:id].to_i
        v.update(mile_params)
        # render json: v.to_json
        head :no_content
      end
    end
  end

  # def create
  #   @mile = current_user.posts.new(post_params)
  #   if  @post.save
  #       # @post.valid?
  #       # @token = issue_token(@user)
  #       # render json: { user: @user, jwt: @token }
  #       render json: {post: @post}
  #   else
  #     render json: { error: 'failed to create user' }, status: :not_acceptable
  #   end
  # end
  def create
    @mile = Milestone.new(mile_params)
    if  @mile.save
        # @post.valid?
        # @token = issue_token(@user)
        # render json: { user: @user, jwt: @token }
        render json: {mile: @mile}
    else
      render json: { error: 'failed to create milestone' }, status: :not_acceptable
    end
  end

  def destroy
    @mil = Milestone.all
    @mil.each do |v|
      if v.id == params[:id].to_i
        v.destroy
        head :no_content
      end
    end
  end

  private

  def mile_params
    # params.require(:user).permit(:username, :password, :email)
    # params.require.permit(:username, :password, :email)
    params.require(:milestone).permit(:title, :instructions, :user_id, :completed)
  end

  def set_milestone
    @mile = Milestone.find_by(id: mile_params[:id])
  end
end
