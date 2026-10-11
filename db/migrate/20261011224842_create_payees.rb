class CreatePayees < ActiveRecord::Migration[8.1]
  def change
    create_table :payees do |t|
      t.references :budget, null: false, foreign_key: { to_table: :budgets, on_delete: :cascade }
      t.string :name, null: false

      t.timestamps
    end

    # Ensure that each payee name is unique within the scope of a budget.
    add_index :payees, [ :budget_id, :name ], unique: true
  end
end
