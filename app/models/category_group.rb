class CategoryGroup < ApplicationRecord
  include BudgetScoped

  # TODO: update migration to reflect dependent: :restrict_with_error for categories
  has_many :categories, dependent: :restrict_with_error
  has_many :transactions, through: :categories

  validates :name, presence: true
end
