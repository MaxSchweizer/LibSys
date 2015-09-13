class LibraryMembersController < ApplicationController
  def index
    @library_members = LibraryMember.all
  end

  def show
    @library_member = LibraryMember.find params[:id]
  end

  def new
  end

  def create
    @library_member = LibraryMember.new message_params

    @library_member.save
    redirect_to @library_member
  end

  def message_params
    params.require(:library_member).permit(:email, :name, :password)
  end
end
