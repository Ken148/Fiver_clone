require "test_helper"

class SellersControllerTest < ActionDispatch::IntegrationTest
  test "should get info" do
    get sellers_info_url
    assert_response :success
  end
end
