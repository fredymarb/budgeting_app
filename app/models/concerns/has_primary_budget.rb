# This concern automatically creates a primary budget with default categories for a new user.
module HasPrimaryBudget
  extend ActiveSupport::Concern

  included do
    after_create :add_primary_budget
  end

  private

  def add_primary_budget
    # Create the primary budget for the new user with default role as owner
    primary_budget = Budget.create!(name: "My Budget")
    memberships.create!(budget: primary_budget, role: :owner)

    # Create default accounts for the primary budget
    primary_budget.accounts.create!(name: "Savings", on_budget: true, kind: :savings)
    primary_budget.accounts.create!(name: "Checking", on_budget: true, kind: :checking)
    primary_budget.accounts.create!(name: "Cash", on_budget: true, kind: :cash)

    # Create default category groups and categories for the primary budget
    default_categories = {
      "Bills" => [ "Rent/Mortgage", "Electric", "Internet", "Phone" ],
      "Needs" => [ "Groceries", "Transportation", "Medical" ],
      "Wants" => [ "Dining Out", "Entertainment", "Fun Money" ]
    }.freeze

    default_categories.each_with_index do |(group_name, names), group_index|
      group = primary_budget.category_groups.create!(name: group_name, position: group_index)
      names.each_with_index { |name, i| group.categories.create!(name: name, budget: primary_budget) }
    end

    checking_account = primary_budget.accounts.find_by!(name: "Checking")
    sample_transactions = [
      {
        payee: "Neighborhood Market",
        category: "Groceries",
        date: Date.current.beginning_of_month + 2.days,
        amount_minor: 7643,
        memo: "Sample transaction - Grocery shopping"
      },
      {
        payee: "Corner Cafe",
        category: "Dining Out",
        date: Date.current.beginning_of_month + 7.days,
        amount_minor: 1850,
        memo: "Sample transaction - Lunch"
      },
      {
        payee: "Property Management",
        category: "Rent/Mortgage",
        date: Date.current.beginning_of_month + 12.days,
        amount_minor: 145000,
        memo: "Sample transaction - Rent"
      }
    ]

    sample_transactions.each do |attributes|
      payee = primary_budget.payees.create!(name: attributes.fetch(:payee))
      category = primary_budget.categories.find_by!(name: attributes.fetch(:category))
      Transaction.create!(
        budget: primary_budget,
        account: checking_account,
        payee: payee,
        category: category,
        date: attributes.fetch(:date),
        amount_minor: attributes.fetch(:amount_minor),
        memo: attributes.fetch(:memo)
      )
    end
  end
end
