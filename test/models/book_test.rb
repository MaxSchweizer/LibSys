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

  # Test functions defined in Book class
  test "book should know it is checked out" do
    # TODO: Figure out how to mock/stub a book connected to a history record
    flunk "test not implemented yet"
    book = Book.new
    assert book.checked_out?
  end

  test "book should know it is not checked out currently" do
    # TODO: Figure out how to mock/stub a book connected to a history record
    flunk "test not implemented yet"
    book = Book.new
    assert_not book.checked_out?
  end

  test "book should know it hasn't been checked out yet" do
    # TODO: Figure out how to mock/stub a book connected to a history record
    flunk "test not implemented yet"
    book = Book.new
    assert_not book.checked_out?
  end
end
