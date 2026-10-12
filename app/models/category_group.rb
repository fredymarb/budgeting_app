class CategoryGroup < ApplicationRecord
  include BudgetScoped

  has_many :categories, dependent: :restrict_with_error
  has_many :transactions, through: :categories

  validates :name, presence: true
end
