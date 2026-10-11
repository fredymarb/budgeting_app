class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories do |t|
      t.references :budget, null: false, foreign_key: { to_table: :budgets, on_delete: :cascade }
      t.references :category_group, null: false, foreign_key: { to_table: :category_groups, on_delete: :cascade }

      t.string :name, null: false
      t.integer :position
      t.integer :goal_type
      t.bigint :goal_amount_minor
      t.date :goal_target_date

      t.timestamps
    end
  end
end
