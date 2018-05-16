require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "Sports")
    @user = User.create(username: "John", email: "john@gmail.com", password: "password", admin: true)
  end

  test "should get index" do
    get categories_path
    assert :success
  end

  test "should get new" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert :success
  end

  test "should get show" do
    get category_path(@category)
    assert_template 'categories/show'
    assert :success
    assert_match 'Sports', response.body
  end

  test "should redirect if user is not an admin" do
    assert_no_difference "Category.count" do
      post categories_path params: {category: {name: "Cars"}}
    end
    assert_redirected_to categories_path
  end

  test "only admin can edit a category name" do
    @category.save
    user2 = User.create(username: "Bob", email: "Bob@gmail.com", password: "password", admin: false)
    sign_in_as(user2, "password")
    get edit_category_path(@category)
    assert_redirected_to categories_path
  end

end