# frozen_string_literal: true

class Category
  class CategoryComponent < ViewComponent::Base
    def initialize(category:, budgeted_minor:, activity_minor:, available_minor:, currency:)
      @category = category
      @budgeted_minor = budgeted_minor
      @activity_minor = activity_minor
      @available_minor = available_minor
      @currency = currency
    end

    def spending_minor
      @activity_minor.abs
    end

    def spending_percent
      return 0 unless @budgeted_minor.positive?

      [ (spending_minor * 100) / @budgeted_minor, 100 ].min
    end

    def funding_label
      return if @budgeted_minor.zero? && spending_minor.zero?
      return "Overspent #{helpers.budget_money(spending_minor, currency: @currency)}" if @budgeted_minor.zero?
      return "Overspent by #{helpers.budget_money(spending_minor - @budgeted_minor, currency: @currency)}" if spending_minor > @budgeted_minor
      return "Fully Spent" if spending_minor == @budgeted_minor
      return "Spent #{helpers.budget_money(spending_minor, currency: @currency)} of #{helpers.budget_money(@budgeted_minor, currency: @currency)}" if spending_minor.positive?

      "Funded"
    end

    def available_class
      return "category-available--overspent" if @available_minor.negative?
      return "category-available--empty" if @available_minor.zero?

      "category-available--funded"
    end
  end
end
