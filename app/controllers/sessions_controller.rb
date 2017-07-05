class SessionsController < ApplicationController
  def new
  end

  def create
    if login(params[:email], params[:password])
      flash[:notice] = '登录成功'
      redirect_to root_path
    else
      flash[:notice] = '邮箱或者密码不正确'
      redirect_to new_session_path
    end
  end

  def destroy
    logout
    flash[:notice] = '退出成功'
    redirect_to root_path
  end
end
