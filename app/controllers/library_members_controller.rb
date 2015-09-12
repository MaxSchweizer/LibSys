class LibraryMembersController < ApplicationController
  def index
    @library_members = LibraryMember.all
  end

  def show
    @library_member = LibraryMember.find params[:id]
  end
end
