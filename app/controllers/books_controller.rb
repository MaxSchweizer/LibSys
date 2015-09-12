class BooksController < ApplicationController
  def index
    case params[:searchType]
      when :author
        @book = Book.find_by_author params[:id]
      else
        @books = Book.all
    end
  end

  def show
    @book = Book.find params[:id]
  end
end
