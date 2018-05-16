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
    assert :success
  end

  test "should redirect if user is not an admin" do
    assert_no_difference "Category.count" do
      post categories_path params: {category: {name: "Cars"}}
    end
    assert_redirected_to categories_path
  end

end