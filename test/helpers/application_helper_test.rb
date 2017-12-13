require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "3days travel"
    assert_equal full_title("Help"), "Help | 3days travel"
  end
end
