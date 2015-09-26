require 'test_helper'

class BooksControllerTest < ActionController::TestCase

  # setup a LibraryMember in session so CanCan authenticates the actions
  def setup
    user = LibraryMember.create!(:name => "n", :email => "n@g.com", :password => "123")
    session[:user_id] = user.id
  end
  # teardown session id so next test refreshes
  def teardown
    session[:user_id] = nil
    user = nil
  end

#===== test search features =============================================================================================================
  test "should be able to search by author with exact string" do
    get :index, {"search_type" => "authors", "query" => "Author0"}
    assert_response :success
    assert_not_nil assigns :books

    assert_equal 1, assigns(:books).length
    assert "ISBN0", assigns(:books)[0].isbn
  end

  test "should be able to search by author with weak match string" do
    get :index, {"search_type" => "authors", "query" => "0"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length == 1), "Incorrect number of books returned. Check fixtures for details."
  end

  test "should be able to search by ISBN with weak match string" do
    get :index, {"search_type" => "isbn", "query" => "0"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length == 5), "Incorrect number of books returned. Check fixtures for details."
  end

  test "should be able to search by ISBN with exact match string" do
    get :index, {"search_type" => "isbn", "query" => "0103"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length <= 1), "Incorrect number of books returned. Check fixtures for details."
    assert "Yellow Brick Road", assigns(:books)[0].title
  end


  test "should be able to search by title with weak match string" do
    get :index, {"search_type" => "title", "query" => "yellow"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length == 3), "Incorrect number of books returned. Check fixtures for details."
  end

  test "should be able to search by title with exact match string" do
    get :index, {"search_type" => "title", "query" => "yellow brick road"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length == 1), "Incorrect number of books returned. Check fixtures for details."
    assert "OZ", assigns(:books)[0].authors
  end


  test "should be able to search by description with weak match string" do
    get :index, {"search_type" => "description", "query" => "yellow"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length == 3), "Incorrect number of books returned. Check fixtures for details."
  end

  test "should be able to search by description with exact match string" do
    get :index, {"search_type" => "description", "query" => "Follow the Yellow Brick Road!"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length == 1), "Incorrect number of books returned. Check fixtures for details."
    assert "OZ", assigns(:books)[0].authors
  end

  test "should be able to search checked out = true " do
    get :index, {"search_type" => "status", "query" => "true"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length == 2), "Incorrect number of books returned. Check fixtures for details."
  end

  test "should be able to search checked out = false " do
    get :index, {"search_type" => "status", "query" => "false"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length == 12), "Incorrect number of books returned. Check fixtures for details."
  end

#=======test other methods ===============================================================================================
  # Test the index
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length == 14), "Incorrect number of books returned. Check fixtures for details."
    # TODO: Write more unit test for this.  Perhaps decrease the number of books in the fixture for comprehensive testing.
  end

   # Test the create
  test "create new book fail as librarymember " do
    post :create, book: {isbn: "200", title: "200", authors: "200", description: "200" } #, status: "false"}
    assert_response :redirect
    #assert_redirected_to book_path(assigns(@book))
  end

  test "create new book suceed as admin " do
    #replace user with admin
    user = Admin.create!(:name => "n", :email => "n@g.com", :password => "123")
    lib_user = LibraryMember.create!(:name => "n2", :email => "n2@g.com", :password => "123")
    session[:user_id] = user.id
    post :create, { book: {isbn: "200", title: "200", author: "200", description: "200" } , status: "false",  library_member:lib_user.id }
    assert_response :redirect
    assert_redirected_to Book.find_by(title: "200"), :action => "show"
    assert "200", Book.find_by(title: "200").author
  end

  test "create new book with bad isbn data" do
    #login as admin
    user = Admin.create!(:name => "n", :email => "n@g.com", :password => "123")
    lib_user = LibraryMember.create!(:name => "n2", :email => "n2@g.com", :password => "123")
    session[:user_id] = user.id
    post :create, { book: {isbn: "0101", title: "200", author: "200", description: "200" } , status: "false",  library_member:lib_user.id }
    assert_response :redirect
  end


  # Test the new
  test "view new book as admin" do
    user = Admin.create!(:name => "n", :email => "n@g.com", :password => "123")
    session[:user_id] = user.id
    get :new
    assert_response :success
  end


  # Test the destroy
  test "destroy book" do
    @bk = Book.find_by(title: "Yellow").id
    #assert_difference 'Book.count', -1 do
      delete :destroy, id: @bk
    #end
    assert_response :redirect
    assert_redirected_to books_path #:book , :action => "index"
  end

  # test "destroy book that doesnt exist" do
  #   flunk "Test not implemented yet"
  # end


end
