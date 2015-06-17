class UsersController < ApplicationController
  def new
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: 201, acl: :public_read)
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to 16photos!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end


  private

  	def user_params
  		params.require(:user).permit(:username, :email, :password, :password_confirmation)
  	end

end
