class TransactionsController < ApplicationController
  before_action :set_budget
  before_action :set_transaction, only: [ :show, :edit, :update, :destroy ]

  def index
    @transactions = budget_transactions.includes(:account, :payee, :category).order(date: :desc, id: :desc)
    render json: @transactions
  end

  def show
    render json: @transaction
  end

  def new
    render json: Transaction.new(budget: @budget)
  end

  def edit
    render json: @transaction
  end

  def create
    @transaction = Transaction.new(budget: @budget)
    assign_transaction_params

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def update
    assign_transaction_params

    if @transaction.save
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy!
    head :no_content
  end

  private

  def set_budget
    @budget = current_user.budgets.first!
  end

  def set_transaction
    @transaction = budget_transactions.find(params[:id])
  end

  def budget_transactions
    Transaction.where(budget_id: @budget.id)
  end

  def assign_transaction_params
    attributes = params.require(:transaction)
    @transaction.assign_attributes(attributes.permit(:date, :amount_minor, :memo, :cleared))
    @transaction.account = @budget.accounts.find(attributes[:account_id]) if attributes[:account_id].present?
    @transaction.payee = @budget.payees.find(attributes[:payee_id]) if attributes[:payee_id].present?
    @transaction.category = @budget.categories.find(attributes[:category_id]) if attributes[:category_id].present?
  end
end
