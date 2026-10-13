# frozen_string_literal: true

class CategoryGroup
  class CategoryGroupComponent < ViewComponent::Base
    def initialize(category_group:, budgeted_by_category:, activity_by_category:, currency:)
      @category_group = category_group
      @categories = category_group.categories.sort_by { |category| [ category.position || 0, category.id ] }
      @budgeted_by_category = budgeted_by_category
      @activity_by_category = activity_by_category
      @currency = currency
    end

    def budgeted_minor
      @categories.sum { |category| @budgeted_by_category.fetch(category.id, 0) }
    end

    def activity_minor
      -@categories.sum { |category| @activity_by_category.fetch(category.id, 0) }
    end

    def available_minor
      budgeted_minor + activity_minor
    end
  end
end
