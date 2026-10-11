class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :budget, null: false, foreign_key: true

      # Role of the user within the budget (e.g., owner, editor, viewer)
      t.integer :role, null: false, default: 0

      t.timestamps
    end

    # Ensure that a user can only have one membership per budget
    add_index :memberships, [ :user_id, :budget_id ], unique: true
  end
end
