require "test_helper"

class MonthlyAllocationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "updates a category's budgeted amount" do
    sign_in users(:one)

    patch category_monthly_allocation_url(categories(:one), monthly_allocations(:one)), params: {
      monthly_allocation: { assigned_amount: "42.75", budget_month: "2026-10-01" }
    }

    assert_redirected_to budget_path(month: "2026-10")
    assert_equal 4_275, monthly_allocations(:one).reload.assigned_minor
  end

  test "creates a monthly allocation when a category has no existing amount" do
    sign_in users(:one)

    assert_difference("MonthlyAllocation.count", 1) do
      post category_monthly_allocations_url(categories(:one)), params: {
        monthly_allocation: { assigned_amount: "125.50", budget_month: "2026-11-01" }
      }
    end

    assert_redirected_to budget_path(month: "2026-11")
    allocation = MonthlyAllocation.find_by!(category: categories(:one), budget_month: Date.new(2026, 11, 1))
    assert_equal 12_550, allocation.assigned_minor
    assert_equal budgets(:one).id, allocation.budget_id
  end

  test "rejects invalid amounts without changing the existing allocation" do
    sign_in users(:one)

    patch category_monthly_allocation_url(categories(:one), monthly_allocations(:one)), params: {
      monthly_allocation: { assigned_amount: "not money", budget_month: "2026-10-01" }
    }

    assert_redirected_to budget_path(month: "2026-10")
    assert_equal 1, monthly_allocations(:one).reload.assigned_minor
    assert_equal "Enter a valid budgeted amount.", flash[:alert]
  end

  test "cannot update an allocation in another budget" do
    sign_in users(:one)

    patch category_monthly_allocation_url(categories(:two), monthly_allocations(:two)), params: {
      monthly_allocation: { assigned_amount: "42.75", budget_month: "2026-10-01" }
    }

    assert_response :not_found
    assert_equal 1, monthly_allocations(:two).reload.assigned_minor
  end
end
