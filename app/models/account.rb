class Account < ApplicationRecord
  include BudgetScoped

  has_many :transactions, dependent: :restrict_with_error

  enum kind: { checking: 0, savings: 1, cash: 2, investment: 3, credit: 4 }

  validates :name, :kind, presence: true
  validates :on_budget, presence: true, inclusion: { in: [ true, false ] }
  validates :closed_at, datetime: true, allow_nil: true
end
