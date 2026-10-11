class CategoryGroup < ApplicationRecord
  include BudgetScoped

  has_many :categories, dependent: :destroy

  validates :name, presence: true
end
