require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:ciaone)
    @users = User.all
  end

  test 'index with pagination' do
    sign_in @user
    get users_path
    assert_template 'users/index'
    @users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.username
    end
  end
end