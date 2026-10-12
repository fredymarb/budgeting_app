# frozen_string_literal: true

require "test_helper"

class SidebarComponentTest < ViewComponent::TestCase
  def test_component_renders_budget_and_user_navigation
    render_inline(Sidebar::SidebarComponent.new(budget: budgets(:one), user: users(:one)))

    assert_selector "aside.sidebar"
    assert_text budgets(:one).name
    assert_text users(:one).email
    assert_link "Budget", href: "/budgets/#{budgets(:one).id}"
  end
end
