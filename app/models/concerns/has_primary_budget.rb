# This concern automatically creates a primary budget with default categories for a new user.
module HasPrimaryBudget
  extend ActiveSupport::Concern

  included do
    after_create :add_primary_budget
  end

  private

  def add_primary_budget
    primary_budget = Budget.create!(name: "My Budget")
    memberships.create!(budget: primary_budget, role: :owner)

    default_categories = {
      "Bills" => [ "Rent/Mortgage", "Electric", "Internet", "Phone" ],
      "Needs" => [ "Groceries", "Transportation", "Medical" ],
      "Wants" => [ "Dining Out", "Entertainment", "Fun Money" ]
    }.freeze

    default_categories.each_with_index do |(group_name, names), group_index|
      group = primary_budget.category_groups.create!(name: group_name, position: group_index)
      names.each_with_index { |name, i| group.categories.create!(name: name, budget: primary_budget) }
    end
  end
end
