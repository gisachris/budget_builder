require "test_helper"

class DealsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get deals_index_url
    assert_response :success
  end

  test "should get show" do
    get deals_show_url
    assert_response :success
  end
end
