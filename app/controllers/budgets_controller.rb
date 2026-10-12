class BudgetsController < ApplicationController
  def show
    @budget = current_user.budgets.first!
  end
end
