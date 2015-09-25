require 'test_helper'

class BooksControllerTest < ActionController::TestCase


  # Test the index
  test "should get index" do

    get :index
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length >= 10)
    # TODO: Write more unit test for this.  Perhaps decrease the number of books in the fixture for comprehensive testing.
  end

  test "should be able to search by author with exact string" do
    get :index, {"search_type" => "author", "query" => "Author0"}
    assert_response :success
    assert_not_nil assigns :books

    assert_equal 1, assigns(:books).length
    assert "ISBN0", assigns(:books)[0].isbn
  end

  test "should be able to search by author with weak match string" do
    get :index, {"search_type" => "author", "query" => "Author"}
    assert_response :success
    assert_not_nil assigns :books

    assert (assigns(:books).length >= 10)
    # TODO: Write more unit test for this.  Perhaps decrease the number of books in the fixture for comprehensive testing.
  end

  # # Test the create
  # test "create new book" do
  #   flunk "Test not implemented yet"
  # end

  # test "create new book with bad data" do
  #   flunk "Test not implemented yet"
  # end
  #
  # # Test the new
  # test "view new book" do
  #   flunk "Test not implemented yet"
  # end
  #
  # # Test the destroy
  # test "destroy book" do
  #   flunk "Test not implemented yet"
  # end
  #
  # test "destroy book that doesnt exist" do
  #   flunk "Test not implemented yet"
  # end


end
