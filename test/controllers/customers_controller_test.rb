require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get customers_main_url
    assert_response :success
  end

end
