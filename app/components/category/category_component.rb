# frozen_string_literal: true

module Category
  class CategoryComponent < ViewComponent::Base
    def initialize(name:, budgeted:, activity:, available:)
      @name = name
      @budgeted = budgeted
      @activity = activity
      @available = available
    end
  end
end
