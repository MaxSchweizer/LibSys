class HistoriesController < ApplicationController
  def update
    @history = History.find params[:id]

    @history.update({:return => Time.now})
    redirect_to :controller => :library_members, :action => :show, :id => @history.library_member_id
  end
end
