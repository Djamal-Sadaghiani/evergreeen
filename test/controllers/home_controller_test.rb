require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get impressum" do
    get home_impressum_url
    assert_response :success
  end

end
