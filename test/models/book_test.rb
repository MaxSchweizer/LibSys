require 'test_helper'

class BookTest < ActiveSupport::TestCase

  # Test the model contraints
  test "should save book with all fields" do
    book = Book.new
    book.author= "author"
    book.title= "title"
    book.description= "description"
    book.isbn="isbn"
    assert book.save
  end

  test "should not save a book with no information" do
    book = Book.new
    assert_not book.save
  end

  test "should not save a book with no isbn" do
    book = Book.new
    book.author= "author"
    book.title= "title"
    book.description= "description"
    assert_not book.save
  end

  test "should not save book with non-unique isbn" do
    book = Book.new
    book.author= "author"
    book.title= "title"
    book.description= "description"
    book.isbn="ISBN0"
    assert_not book.save
  end

  test "book can access its histories dependants" do
    book = Book.find_by_isbn "ISBN0"
    assert_equal 3, book.histories.length

    book = Book.find_by_isbn "ISBN1"
    assert_equal 1, book.histories.length

    book = Book.find_by_isbn "ISBN2"
    assert_equal 1, book.histories.length

    book = Book.find_by_isbn "ISBN3"
    assert_equal 0, book.histories.length
  end

  # Test functions defined in Book class
  test "book should know it is checked out" do
    # Multi-checkout book
    book = Book.find_by_isbn "ISBN0"
    assert book.checked_out?

    # Single checkout book
    book = Book.find_by_isbn "ISBN1"
    assert book.checked_out?
  end

  test "book should know it is not checked out currently" do
    book = Book.find_by_isbn "ISBN2"
    assert_not book.checked_out?
  end

  test "book should know it hasn't been checked out yet" do
    book = Book.find_by_isbn "ISBN3"
    assert_not book.checked_out?
  end
end
