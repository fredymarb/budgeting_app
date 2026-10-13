class BudgetsController < ApplicationController
  def show
    @budget = current_user.budgets.first!
    @month = month_param(params[:month])
  end

  private

  # Parses a year-month selector and falls back to the current month if invalid.
  def month_param(budget_month)
    Date.strptime("#{budget_month}-01", "%Y-%m-%d")
  rescue ArgumentError, TypeError
    Date.current.beginning_of_month
  end
end
