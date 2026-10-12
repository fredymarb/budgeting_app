require "test_helper"

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "shows the signed-in user's budget" do
    sign_in users(:one)

    get budget_url(budgets(:one))

    assert_response :success
  end
end
