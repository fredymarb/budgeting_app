class CreateAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :accounts do |t|
      t.references :budget, null: false, foreign_key: { to_table: :budgets, on_delete: :cascade }
      t.string :name, null: false
      t.integer :kind, null: false
      t.boolean :on_budget, null: false, default: true
      t.datetime :closed_at

      t.timestamps
    end
  end
end
