class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :budget

  enum :role, { owner: 0, editor: 1, viewer: 2 }

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :budget_id }
end
