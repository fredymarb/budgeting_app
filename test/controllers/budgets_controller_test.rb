require "test_helper"

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get budgets_show_url
    assert_response :success
  end
end
