class AccountsController < ApplicationController
  before_action :set_budget, only: [ :show, :new, :create, :edit, :update, :close ]
  before_action :set_account, only: [ :show, :edit, :update, :close ]

  def index
    budget = current_user.budgets.find(params[:budget_id])
    @accounts = budget.accounts
  end

  def show
    @account = @budget.accounts.find(params[:id])
  end

  def new
    @account = @budget.accounts.new
  end

  def create
    @account = @budget.accounts.new(account_params)

    if @account.save
      # Redirect to the account's index page within the context of the budget
      redirect_to budget_accounts_path(@budget, @account), notice: "Account was successfully created."
    else
      flash.now[:alert] = "There was an error creating the account."
      render :new
    end
  end

  def edit
  end

  def update
    if @account.update(account_params)
      redirect_to budget_accounts_path(@budget, @account), notice: "Account was successfully updated."
    else
      render :edit
    end
  end

  def close
    @account.update!(closed: true)
    redirect_to budget_accounts_path(@budget), notice: "Account was successfully closed."
  end

  private

  def set_budget
    @budget = current_user.budgets.find(params[:budget_id])
  end

  def set_account
    @account = @budget.accounts.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :kind, :on_budget, :closed_at)
  end
end
