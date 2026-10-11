class CreateCategoryGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :category_groups do |t|
      t.references :budget, null: false, foreign_key: { to_table: :budgets, on_delete: :cascade }
      t.string :name, null: false
      t.integer :position

      t.timestamps
    end
  end
end
