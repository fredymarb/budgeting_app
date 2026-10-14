class MonthlyAllocationsController < ApplicationController
  before_action :set_budget_and_category

  def create
    save_monthly_allocation(create: true)
  end

  def update
    @monthly_allocation = @budget.monthly_allocations
      .where(category: @category)
      .find(params[:id])
    save_monthly_allocation
  end

  private

  def set_budget_and_category
    @budget = current_user.budgets.first!
    category_group = @budget.category_groups.find(params[:category_group_id])
    @category = category_group.categories.find(params[:category_id])
  end

  def save_monthly_allocation(create: false)
    attributes = params.require(:monthly_allocation).permit(:assigned_amount, :budget_month)
    @selected_budget_month = budget_month(attributes[:budget_month])
    if create
      @monthly_allocation = @category.monthly_allocations.find_or_initialize_by(budget_month: @selected_budget_month)
    end
    @monthly_allocation.budget = @budget
    @monthly_allocation.assigned_minor = Money.parse_to_minor(
      attributes[:assigned_amount],
      exponent: Money::EXPONENTS.fetch(@budget.currency, 2)
    )
    @monthly_allocation.budget_month = @selected_budget_month

    if @monthly_allocation.save
      redirect_to budget_path(month: @selected_budget_month.strftime("%Y-%m")), notice: "Budgeted amount updated."
    else
      redirect_to budget_path(month: @selected_budget_month.strftime("%Y-%m")), alert: @monthly_allocation.errors.full_messages.to_sentence
    end
  rescue ArgumentError
    redirect_to budget_path(month: @selected_budget_month&.strftime("%Y-%m")), alert: "Enter a valid budgeted amount."
  end

  def budget_month(value = params.dig(:monthly_allocation, :budget_month))
    Date.strptime(value.to_s, "%Y-%m-%d").beginning_of_month
  end
end
