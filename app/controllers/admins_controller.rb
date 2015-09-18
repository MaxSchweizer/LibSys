class AdminsController < ApplicationController
  def index
    @admins = Admin.all
  end

  def show
    @admin = Admin.find params[:id]
  end

  def edit
    @admin = Admin.find params[:id]
  end

  def update
    @admin = Admin.find params[:id]

    if @admin.update message_params
      redirect_to @admin
    else
      render :edit
    end
  end

  def new
    @admin = Admin.new
  end

  def destroy
    @admin = Admin.find params[:id]
    @admin.destroy

    redirect_to admins_path
  end

  def create
    @admin = Admin.new message_params

    if @admin.save
      redirect_to @admin
    else
      render :new
    end
  end

  private
  def message_params
    params.require(:admin).permit(:email, :name, :password, :password_confirmation)
  end
end