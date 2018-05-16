require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "John", email: "john@example.com", password: "password", admin: true)
  end

  # follows the natural flow of an user

  test "get a new category form and create a new category" do 
    sign_in_as(@user, "password")

    # first, we get the new category path
    get new_category_path
    
    # assert that we have the new category template rendered
    assert_template 'categories/new'

    # assert that we have one more category after adding sports into categories
    assert_difference 'Category.count', 1 do
      post categories_path, params: {category: {name: "Sports"}}
      follow_redirect!
    end

    assert_template 'categories/index'
    assert_match 'Sports', response.body
  end

  test "get a new invalid category and fail the creation of it" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 0 do
      post categories_path, params: {category: {name: " "}}
    end
    assert_template 'categories/new'

    #error partials are showing up
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body' 
  end

end