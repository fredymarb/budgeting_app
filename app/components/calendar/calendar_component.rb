# frozen_string_literal: true

module Calendar
  class CalendarComponent < ViewComponent::Base
    def initialize(month:)
      @month = month
    end
  end
end
