require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
	#def setup
#		@place = Place.new(title: "place title", description: "place description")
#	end

#	test "should be valid" do
#		assert @place.valid?
#	end

#	test "user_id should be present" do
#		@place.user_id = nil
#		assert_not @place.valid?
#	end

	def setup
		@user = users(:ciaone)
		@place = @user.places.build(title:"PlaceTitle", description:"Wonderful place", lat:"1.111111", long:"2.222222", user_id: @user.id)
	end

	test "should be valid" do
		assert @place.valid?
	end

	test "user_id should be present" do
		@place.user_id = nil
		assert_not @place.valid?
	end

	test "title should be present" do
		@place.title = "  "
		assert_not @place.valid?
	end

	test "lat should be present" do
		@place.lat = nil
		assert_not @place.valid?
	end

	test 'lat should be a number' do
		@place.lat = "not_a_number"
		assert_not @place.valid?
	end

	test 'long should be a number' do
		@place.long = "not_a_number"
		assert_not @place.valid?
	end

	test "long should be present" do
		@place.long = nil
		assert_not @place.valid?
	end
end
