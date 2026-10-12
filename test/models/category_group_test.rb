require "test_helper"

class CategoryGroupTest < ActiveSupport::TestCase
  test "cannot delete a category group with categories" do
    category_group = category_groups(:one)

    assert_not category_group.destroy
    assert category_group.persisted?

    assert_raises ActiveRecord::StatementInvalid do
      category_group.delete
    end
  end
end
