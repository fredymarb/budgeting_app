require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "lists only transactions belonging to the signed-in user's budget" do
    sign_in users(:one)

    get transactions_url, as: :json

    assert_response :success
    assert_equal [ transactions(:one).id ], response.parsed_body.map { |transaction| transaction.fetch("id") }
  end

  test "creates transactions in the signed-in user's budget" do
    sign_in users(:one)

    post transactions_url, params: {
      transaction: {
        budget_id: budgets(:two).id,
        account_id: accounts(:one).id,
        payee_id: payees(:one).id,
        category_id: categories(:one).id,
        date: Date.current,
        amount_minor: 2500,
        memo: "New transaction"
      }
    }, as: :json

    assert_response :created
    assert_equal budgets(:one).id, Transaction.find(response.parsed_body.fetch("id")).budget_id
  end

  test "cannot access a transaction from another budget" do
    sign_in users(:one)

    get transaction_url(transactions(:two)), as: :json

    assert_response :not_found
  end
end
