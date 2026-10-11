class Payee < ApplicationRecord
  include BudgetScoped

  validates :name, presence: true, uniqueness: { scope: :budget_id }
end
