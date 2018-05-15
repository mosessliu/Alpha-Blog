require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "Sports")
  end

  test "should get index" do
    get categories_path
    assert :success
  end

  test "should get new" do
    get new_category_path
    assert :success
  end

  test "should get show" do
    get category_path(@category)
    assert :success
  end

end