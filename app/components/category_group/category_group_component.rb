# frozen_string_literal: true

module CategoryGroup
  class CategoryGroupComponent < ViewComponent::Base
    def initialize(name:)
      @name = name
    end
  end
end
