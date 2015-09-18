class LibraryMembersController < ApplicationController
  def index
    @library_members = LibraryMember.all
  end

  def show
    @library_member = LibraryMember.find params[:id]
  end

  def edit
    @library_member = LibraryMember.find params[:id]
  end

  def update
    @library_member = LibraryMember.find params[:id]

    if @library_member.update message_params
      redirect_to @library_member
    else
      render :edit
    end
  end

  def new
    @library_member = LibraryMember.new
  end

  def create
    @library_member = LibraryMember.new message_params

    if @library_member.save
      redirect_to @library_member
    else
      render :new
    end
  end

  private
  def message_params
    params.require(:library_member).permit(:email, :name, :password, :password_confirmation)
  end
end