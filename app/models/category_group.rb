class CategoryGroup < ApplicationRecord
  include BudgetScoped

  validates :name, presence: true
end
