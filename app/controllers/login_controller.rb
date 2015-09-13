class LoginController < ApplicationController
  def index
  end

  def login
    @user_name = params[:name]
    #@password = params[:"Password"]
  end
end
