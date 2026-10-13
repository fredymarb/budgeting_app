# frozen_string_literal: true

module Sidebar
  class SidebarComponent < ViewComponent::Base
    def initialize(budget:, user:)
      @budget = budget
      @accounts = @budget.accounts.order(:name)
      @user = user
    end

    def budget_accounts
      @accounts.select { |account| account.on_budget? && !account.closed_at? }
    end

    def tracking_accounts
      @accounts.select { |account| !account.on_budget? && !account.closed_at? }
    end

    def closed_accounts
      @accounts.select(&:closed_at?)
    end
  end
end
