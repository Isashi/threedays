require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:ciaone)
    sign_in @user
  end

  test 'profile page' do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', "#{@user.username} | 3days travel"
    assert_select 'h1', text: @user.username
    assert_select 'img'
  end
end