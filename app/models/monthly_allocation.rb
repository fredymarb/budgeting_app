class MonthlyAllocation < ApplicationRecord
  include BudgetScoped
  scoped_to_budget :category

  belongs_to :category

  validates :budget_month, :category, presence: true
  validates :assigned_minor, numericality: { greater_than_or_equal_to: 0 }
  validates :category_id, uniqueness: { scope: :budget_month }
end
