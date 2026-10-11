class Category < ApplicationRecord
  include BudgetScoped
  scoped_to_budget :category_group

  belongs_to :category_group

  has_many :monthly_allocations, dependent: :destroy

  enum goal_type: {
    weekly_funding: 0,
    bi_weekly_funding: 1,
    monthly_funding: 2,
    target_balance: 3,
    target_date: 4
  }

  validates :name, presence: true
  validates :goal_amount_minor, numericality: { greater_than: 0 }, if: -> { goal_type.present? }
  validates :goal_target_date, presence: true, if: -> { target_date? }
end
