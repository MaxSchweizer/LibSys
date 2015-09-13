class BooksController < ApplicationController
  def index
    case params[:searchType]
      when :author
        @book = Book.find_by_author params[:id]
      else
        @books = Book.all
    end
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find params[:id]
  end

  def create
    @book = Book.new message_params

    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def message_params
    params.require(:book).permit(:isbn, :title, :author, :description)
  end

end
