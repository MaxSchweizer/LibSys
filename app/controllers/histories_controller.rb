class HistoriesController < ApplicationController
  def update
    @history = History.find params[:id]

    @history.update({:return => Time.now})
    redirect_to :back
  end

  def create
    @history = History.new book_id: params[:data], library_member_id: current_user.id, checkout: Time.now
    @history.save
    redirect_to :back
  end
end
