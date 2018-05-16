require 'test_helper'

class SuccessfulCreates < ActionDispatch::IntegrationTest

  def setup
   @user = User.new(username: "Kay", email: "Kay@example.com", password: "password", admin: false)
   @user2 = User.create(username: "Jay", email: "Jay@example.com", password: "password", admin: false)
  end

  test "user should be able to sign up" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: @user.username, email: @user.email, password: @user.password}}
    end
    assert_redirected_to user_path(User.last)
  end

  test "create article successfully" do
    sign_in_as(@user2, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: {title: "Hello World", descriptio: "Hello World! This is me!"}}
    end
    assert_redirected_to article_path(Article.last)
  end

end