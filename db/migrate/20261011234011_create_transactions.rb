class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.references :budget, null: false, foreign_key: { to_table: :budgets, on_delete: :cascade }
      t.references :account, null: false, foreign_key: { to_table: :accounts, on_delete: :restrict }
      t.references :payee, null: true, foreign_key: { to_table: :payees, on_delete: :restrict }
      t.references :category, null: true, foreign_key: { to_table: :categories, on_delete: :restrict }
      t.date :date, null: false
      t.bigint :amount_minor, null: false
      t.string :memo
      t.integer :cleared, null: false, default: 0

      t.timestamps
    end
  end
end
