class Budget < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :accounts, dependent: :destroy
  has_many :category_groups, dependent: :destroy
  has_many :categories, through: :category_groups
  has_many :payees, dependent: :destroy

  validates :name, :currency, presence: true
end
