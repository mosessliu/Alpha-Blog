require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category1 = Category.create(name: "Sports")
    @category2 = Category.create(name: "Games")
  end

  test "list all categories and check each category's link" do
    get categories_path
    assert_template "categories/index"
    assert_select "a[href=?]", category_path(@category1), text: @category1.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end

  
  
end