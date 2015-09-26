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
    if @library_member == current_user
      if @library_member.update library_member_params
        redirect_to @library_member
      else
        render :edit
      end
    end
  end

  def new
    @library_member = LibraryMember.new
  end

  def create
    @library_member = LibraryMember.new library_member_params

    if @library_member.save
      flash[:message] = "Created new Library Member. Please login."
      redirect_to :login
    else
      render :new
    end
  end

  private
  def library_member_params
    params.require(:library_member).permit(:email, :name, :password, :password_confirmation)
  end
end