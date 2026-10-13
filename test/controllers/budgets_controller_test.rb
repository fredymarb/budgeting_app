require "test_helper"

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "shows the signed-in user's budget" do
    sign_in users(:one)

    get root_url

    assert_response :success
    assert_select ".category-budget-table"
    assert_select ".category-group-name", text: /#{Regexp.escape(category_groups(:one).name)}/
    assert_select ".category-name", text: categories(:one).name
  end
end
