class Budget < ApplicationRecord
  validates :name, :currency, presence: true
end
