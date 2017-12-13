require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:ciaone)
    sign_in @user
  end

  test 'an unsuccessful edit' do
    get edit_user_registration_path
    assert_template 'devise/registrations/edit'
    patch user_registration_path, params: { user: {
        username: '',
        email: 'user@invalid',
        password: 'foo',
        password_confirmation: 'bar'
    } }
    assert_template 'devise/registrations/edit'
  end

  test 'a successful edit' do
    get edit_user_registration_path
    assert_template 'devise/registrations/edit'
    email = 'newciaone@gmail.com'
    username = "newciaone"
    patch user_registration_path, params: { user: {
        username: username,
        email: email,
        password: '',
        password_confirmation: '',
        current_password: 'password87'
    } }
    assert_response :redirect
    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash.empty?
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', edit_user_registration_path
    @user.reload
    assert_equal @user.username, username
    assert_equal @user.email, email   
  end
end