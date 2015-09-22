class LoginController < ApplicationController

  def index
  end

  def create
    user = User.find_by(email: params[:login][:email], type: params[:login][:type])
    if user && user.authenticate(params[:login][:password])
      log_in user
      redirect_to user
    else
      flash[:danger] = "Bad login. Please try with a different login/password."
      render :index
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
