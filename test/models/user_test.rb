require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "creates an owned primary budget with default categories" do
    user = User.create!(email: "primary-budget-#{SecureRandom.hex(8)}@example.com", password: "password123")

    budget = user.budgets.first
    assert_equal "My Budget", budget.name
    assert user.memberships.find_by!(budget: budget).owner?
    assert_equal 3, budget.category_groups.count
    assert_equal 10, budget.categories.count
  end
end
