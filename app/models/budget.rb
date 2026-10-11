class Budget < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :accounts, dependent: :destroy
  has_many :category_groups, dependent: :destroy

  validates :name, :currency, presence: true
end
