require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  # TODO: Write more tests for the controller...

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns :books
  end
end
