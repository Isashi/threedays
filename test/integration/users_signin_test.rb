require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = users(:ciaone)
  end

  test 'invalid login submission' do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: {session: {username: "", password: ""}}
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
	end

  test 'sign in with valid credentials' do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { user: { username: @user.username,
                                              password: 'password87' } }
    assert_redirected_to root_path
    follow_redirect!
    assert_not flash.empty?
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', user_path(@user)
  end

  test 'sign in and logout' do
    sign_in @user
    get root_path
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path
    delete destroy_user_session_path
    assert_redirected_to root_path
    follow_redirect!
    assert_not flash.empty?
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', new_user_session_path
    assert_select 'a[href=?]', new_user_registration_path
    assert_select 'a[href=?]', destroy_user_session_path, count: 0
  end
end