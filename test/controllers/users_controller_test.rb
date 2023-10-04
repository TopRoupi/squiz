require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get setup" do
    get users_setup_url
    assert_response :success
  end
end
