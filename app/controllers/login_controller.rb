class LoginController < ApplicationController

  def index
  end

  def create
    admin = Admin.find_by(email: params[:login][:email])
    if admin && admin.authenticate(params[:login][:password])
      log_in admin
      redirect_to admin
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
