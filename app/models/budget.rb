class Budget < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  # TODO: update migration to reflect dependent: :restrict_with_error
  # for accounts, category_groups, and payees
  has_many :accounts, dependent: :restrict_with_error
  has_many :category_groups, dependent: :restrict_with_error
  has_many :categories, through: :category_groups
  has_many :payees, dependent: :restrict_with_error
  has_many :monthly_allocations, through: :categories

  validates :name, :currency, presence: true
end
