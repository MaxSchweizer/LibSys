class LoginController < ApplicationController

  def index
  end

  def create
    user = User.find_by(email: params[:login][:email])
    if user && user.authenticate(params[:login][:password])
      log_in user
      redirect_to user
    else
      flash[:danger] = "Bad Admin Login"
      render :index
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
