require 'test_helper'

class DealingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get dealings_new_url
    assert_response :success
  end

end
