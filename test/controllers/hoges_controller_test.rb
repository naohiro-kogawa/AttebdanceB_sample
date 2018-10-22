require 'test_helper'

class HogesControllerTest < ActionDispatch::IntegrationTest
  test "should get test" do
    get hoges_test_url
    assert_response :success
  end

end
