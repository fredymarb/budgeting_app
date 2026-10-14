class BudgetsController < ApplicationController
  def show
    @budget = current_user.budgets.first!
    @month = month_param(params[:month])
    @category_groups = @budget.category_groups.includes(:categories).order(:position, :id)

    category_ids = @category_groups.flat_map { |group| group.categories.map(&:id) }
    month_range = @month.beginning_of_month..@month.end_of_month

    monthly_allocations = @budget.monthly_allocations
      .where(category_id: category_ids, budget_month: month_range)
    @budgeted_by_category = monthly_allocations.pluck(:category_id, :assigned_minor).to_h
    @allocation_id_by_category = monthly_allocations.pluck(:category_id, :id).to_h
    @activity_by_category = Transaction.where(
      budget_id: @budget.id,
      category_id: category_ids,
      date: month_range
    )
      .group(:category_id)
      .sum(:amount_minor)
  end

  private

  # Parses a year-month selector and falls back to the current month if invalid.
  def month_param(budget_month)
    Date.strptime("#{budget_month}-01", "%Y-%m-%d")
  rescue ArgumentError, TypeError
    Date.current.beginning_of_month
  end
end
