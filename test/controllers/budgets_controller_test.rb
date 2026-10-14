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

  test "shows the budget calendar for the selected month" do
    sign_in users(:one)

    get budget_url(month: "2026-10")

    assert_response :success
    assert_select "[data-controller='budget-calendar'][data-budget-calendar-month-value='2026-10']"
    assert_select ".calendar-current-month", text: "Oct 2026"
    assert_select "button[aria-label='Previous month'][data-action='budget-calendar#previous']"
    assert_select "button[aria-label='Next month'][data-action='budget-calendar#next']"
  end
end
