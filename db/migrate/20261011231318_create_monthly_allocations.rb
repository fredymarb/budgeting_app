class CreateMonthlyAllocations < ActiveRecord::Migration[8.1]
  def change
    create_table :monthly_allocations do |t|
      t.references :budget, null: false, foreign_key: { to_table: :budgets, on_delete: :cascade }
      t.references :category, null: false, foreign_key: { to_table: :categories, on_delete: :cascade }
      t.date :budget_month, null: false
      t.bigint :assigned_minor, null: false, default: 0

      t.timestamps
    end

    # Ensure that each category has only one allocation per budget month
    add_index :monthly_allocations, [ :category_id, :budget_month ], unique: true
  end
end
