# frozen_string_literal: true

module Sidebar
  class SidebarComponent < ViewComponent::Base
    def initialize(budget:, user:)
      @budget = budget
      @accounts = @budget.accounts
      @user = user
    end
  end
end
