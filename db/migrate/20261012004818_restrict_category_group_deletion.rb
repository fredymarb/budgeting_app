class RestrictCategoryGroupDeletion < ActiveRecord::Migration[8.1]
  def up
    remove_foreign_key :categories, :category_groups
    add_foreign_key :categories, :category_groups, on_delete: :restrict
  end

  def down
    remove_foreign_key :categories, :category_groups
    add_foreign_key :categories, :category_groups, on_delete: :cascade
  end
end
