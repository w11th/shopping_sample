class UsersController < ApplicationController
  def new
    @is_using_email = true
    @user = User.new
  end

  def create
    @is_using_email = params[:user] && !params[:user][:email].blank?

    @user = User.new(user_params)
    @user.uuid = session[:user_uuid]

    if @user.save
      flash[:notice] = '注册成功, 请登录'
      redirect_to new_session_path
    else
      render action: :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :cellphone, :token, :password, :password_confirmation)
  end
end
