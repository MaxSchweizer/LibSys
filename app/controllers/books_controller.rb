class BooksController < ApplicationController
  SEARCH_ACTIONS = ["isbn", "title", "author", "description"]

  def index
    search_type, query = params["search_type"], params["query"]
    if "status" == search_type then
      @books = Book.all.find_all { |book| book.checked_out?.to_s == query }
    elsif SEARCH_ACTIONS.include? search_type then
      @books = Book.where "#{search_type} LIKE ?", "%#{query}%"
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

  def destroy
    @book = Book.find params[:id]
    @book.destroy

    # TODO: This may need to be a different redirect...
    redirect_to book_path
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
