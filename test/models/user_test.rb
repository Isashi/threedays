require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:ciaone)
  end


#USER CHECK
	test "should be valid" do
		assert @user.valid?
	end


#USERNAME CHECK
	test "username should be present" do
		@user.username = "   "
		assert_not @user.valid?
	end

	test "username should not be too long" do
		@user.username = "a"*51
		assert_not @user.valid?
	end

	test "username should not be too short" do
		@user.username = "a"*4
		assert_not @user.valid?
	end

	test "username should be saved as lower-case" do
		mixed_case_username = "CiaAonE"
		@user.username = mixed_case_username
		@user.save
		assert_equal mixed_case_username.downcase, @user.reload.username
	end

#EMAIL CHECK
	test "email should be present" do
		@user.email = "   "
		assert_not @user.valid?
	end

	test "email should be valid" do
		emails = ["ciao@gmail.it", "ciaociao@gmail.it", "pastaefaseui@gmail.com"]
		emails.each do |email|
			@user.email = email
			assert @user.valid?
		end
	end

	test "email address should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		duplicate_user.username = @user.username.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email should be not valid" do
		emails = ["ciao@gmail", "ciaoatgmail.it", "&&£££@gmail.com"]
		emails.each do |email|
			@user.email = email
			assert_not @user.valid?
		end
	end

	test "email should not be too short" do
		@user.email = "a"+"@gmail.com"
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = ("a"*246)+"@gmail.com"
		assert_not @user.valid?
	end

	test "email should be saved as lower-case" do
		mixed_case_email = "CiAOnE@gMaIl.COM"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end

#PASSWORD CHECK
	test "password should be present" do
		@userro = User.new(username:"Userro", password:"", email:"userro@gmail.com")
		assert_not @userro.valid?
	end

	test "password should be strong" do
		passwords = ["ciao3", "ciaociao", "1234567"]
		passwords.each do |password|
			@user.password = password
			assert_not @user.valid?
		end	
	end

end
