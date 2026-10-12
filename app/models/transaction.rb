class Transaction < ApplicationRecord
  include BudgetScoped
  scoped_to_budget :account, :payee, :category

  belongs_to :account
  belongs_to :payee
  belongs_to :category

  enum :cleared, { uncleared: 0, cleared: 1, reconciled: 2 }

  validates :account, :date, presence: true
  validates :amount_minor, presence: true, numericality: { greater_than: 0 }
  validates :cleared, presence: true
end
