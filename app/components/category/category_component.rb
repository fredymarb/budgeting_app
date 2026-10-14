# frozen_string_literal: true

class Category
  class CategoryComponent < ViewComponent::Base
    def initialize(category:, budgeted_minor:, allocation_id:, activity_minor:, available_minor:, budget_month:, currency:)
      @category = category
      @budgeted_minor = budgeted_minor
      @allocation_id = allocation_id
      @activity_minor = activity_minor
      @available_minor = available_minor
      @budget_month = budget_month
      @currency = currency
    end

    def allocation_path
      if @allocation_id
        helpers.category_group_category_monthly_allocation_path(
          @category.category_group_id,
          @category,
          @allocation_id
        )
      else
        helpers.category_group_category_monthly_allocations_path(
          @category.category_group_id,
          @category
        )
      end
    end

    def allocation_method
      @allocation_id ? :patch : :post
    end

    def budgeted_amount
      Money.format_from_minor(@budgeted_minor, exponent: Money::EXPONENTS.fetch(@currency, 2))
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
