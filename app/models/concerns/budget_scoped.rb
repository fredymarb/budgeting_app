# Guards against cross-tenant references: every associated record named in
# `scoped_to_budget` must belong to the same budget as this record.
module BudgetScoped
  extend ActiveSupport::Concern

  included do
    belongs_to :budget
    class_attribute :budget_scoped_associations, default: []
    validate :associations_belong_to_budget
  end

  class_methods do
    # Declares associations that must point to the same budget as the record.
    def scoped_to_budget(*associations)
      self.budget_scoped_associations = associations
    end
  end

  private

  # Rejects cross-budget references to associated records.
  def associations_belong_to_budget
    budget_scoped_associations.each do |name|
      record = public_send(name)
      errors.add(name, "must belong to the same budget") if record && record.budget_id != budget_id
    end
  end
end
