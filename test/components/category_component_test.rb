# frozen_string_literal: true

require "test_helper"

class CategoryComponentTest < ViewComponent::TestCase
  def test_renders_category_allocation_activity_and_available_amount
    render_inline(Category::CategoryComponent.new(
      category: categories(:one),
      budgeted_minor: 40_000,
      allocation_id: monthly_allocations(:one).id,
      activity_minor: -10_000,
      available_minor: 30_000,
      budget_month: Date.new(2026, 10, 1),
      currency: "USD"
    ))

    assert_selector ".category-budget-row"
    assert_text categories(:one).name
    assert_text "Spent $100.00 of $400.00"
    assert_text "$400.00"
    assert_text "-$100.00"
    assert_text "$300.00"
    assert_selector ".category-progress[aria-valuenow='25']"
    assert_selector "summary", text: "$400.00"
    assert_selector "input[name='monthly_allocation[assigned_amount]'][value='400.00']", visible: :all
    assert_selector "input[name='monthly_allocation[budget_month]'][value='2026-10-01']", visible: :all
  end
end
