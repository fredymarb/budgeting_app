# frozen_string_literal: true

require "test_helper"

class CategoryGroupComponentTest < ViewComponent::TestCase
  def test_renders_group_totals_and_categories
    category = categories(:one)

    render_inline(CategoryGroup::CategoryGroupComponent.new(
      category_group: category_groups(:one),
      budgeted_by_category: { category.id => 40_000 },
      activity_by_category: { category.id => 10_000 },
      currency: "USD"
    ))

    assert_selector ".category-group-section[open]"
    assert_selector ".category-group-row", text: category_groups(:one).name
    assert_text "$400.00"
    assert_text "-$100.00"
    assert_text "$300.00"
    assert_selector ".category-budget-row", count: 1
  end
end
