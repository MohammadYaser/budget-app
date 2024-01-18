class ExpensesController < ApplicationController
  # GET /users/:user_id/categories/:category_id/expenses
  def index
    # Finds the user based on the :user_id parameter from the request.
    @user = User.find(params[:user_id])
    
    # Finds the category based on the :category_id parameter from the request.
    @category = Category.find(params[:category_id])
    
    # Retrieves expenses associated with the specified user and category, including the category information.
    @expenses = @user.expenses.includes(:category).where(category: @category)
  end

  # GET /users/:user_id/categories/:category_id/expenses/new
  def new
    # Finds the user based on the :user_id parameter from the request.
    @user = User.find(params[:user_id])
    
    # Finds the category based on the :category_id parameter from the request.
    @category = Category.find(params[:category_id])
    
    # Initializes a new expense instance to be used in the 'new' view.
    @expense = Expense.new
    
    # Retrieves all categories to be used for dropdown selection in the 'new' view.
    @categories = Category.all
  end

  # POST /users/:user_id/categories/:category_id/expenses
  def create
    # Finds the user based on the :user_id parameter from the request.
    @user = User.find(params[:user_id])
    
    # Finds the category based on the category_id submitted in the expense parameters.
    @category = Category.find(params[:expense][:category_id])
    
    # Builds a new expense associated with the selected category and populates it with the submitted parameters.
    @expense = @category.expenses.build(expense_params)
    
    # Sets the author of the expense to the current user.
    @expense.author = @user

    # Saves the expense and handles the redirection based on the outcome.
    if @expense.save
      redirect_to user_category_expenses_path(@user, @category), notice: 'Expense was successfully created.'
    else
      # If saving fails, retrieves all categories to be used for dropdown selection in the 'new' view.
      @categories = Category.all
      
      # Renders the 'new' view to display error messages.
      render :new
    end
  end

  private

  # Defines the allowed parameters for expense creation.
  def expense_params
    params.require(:expense).permit(:name, :amount, :transaction_date, :category_id)
  end
end
