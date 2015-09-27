class BooksController < ApplicationController
  SEARCH_ACTIONS = ["isbn", "title", "authors", "description"]

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
    library_members_formatted
    @book = Book.new
  end

  def edit
    library_members_formatted
    @book = Book.find params[:id]
  end

  def update
    @book = Book.find params[:id]

    if @book.update book_params
      update_book_history unless params[:library_member].nil?
      redirect_to @book
    else
      load_edit
    end
  end

  def show
    @book = Book.find params[:id]
  end

  def destroy
    @book = Book.find params[:id]
    @book.destroy

    redirect_to books_path
  end

  def create
    @book = Book.new book_params

    if @book.save
      save_book_history unless params[:library_member].nil?
      redirect_to @book
    else
      load_new
    end
  end

  def load_new
    library_members_formatted
    render :new
  end

  def load_edit
    library_members_formatted
    render :edit
  end

  def library_members_formatted
    @library_members = []
    LibraryMember.all.each do |library_member|
      @library_members << [library_member.email, library_member.id]
    end
  end

  private
  def book_params
    params.require(:book).permit(:isbn, :title, :authors, :description, :status)
  end

  def save_book_history
    library_member = LibraryMember.find params[:library_member]
    load_new if library_member.nil?
    if params[:status] == 'true'
      load_new unless History.create(checkout: Time.now, book_id: @book.id, library_member_id: library_member.id)
    end
  end

  def update_book_history
    library_member = LibraryMember.find params[:library_member]
    load_edit if library_member.nil?
    if params[:status] == 'true'
      load_edit unless History.create(checkout: Time.now, book_id: @book.id, library_member_id: library_member.id)
    else
      history = @book.last_checked_out
      if !history.nil? && !history.update(return: Time.now)
        load_edit
      end
    end
  end
end
