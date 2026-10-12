class Payee < ApplicationRecord
  include BudgetScoped

  # TODO: update migration to reflect dependent: :restrict_with_error for transactions
  has_many :transactions, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { scope: :budget_id }
end
