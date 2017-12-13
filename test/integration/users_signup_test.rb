require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup submission' do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: { user: {
        username: '',
        email: 'user@invalid',
        password: 'foo',
        password_confirmation: 'bar'
      } }
    end
    assert_template 'devise/registrations/new'
	end

	test 'valid signup submission' do
		get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: {
        username: 'Balabiot',
        email: 'balabiot@example.com',
        password: 'balabiot87',
        password_confirmation: 'balabiot87'
      } }
		end
    assert_response :redirect
    follow_redirect!
		assert_template 'static_pages/home'
    assert_select 'a[href=?]', new_user_session_path, count: 0
		assert_select 'a[href=?]', destroy_user_session_path
	end
end