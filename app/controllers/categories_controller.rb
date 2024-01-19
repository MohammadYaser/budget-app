class CategoriesController < ApplicationController
  # This before_action ensures that the set_user method is called before any other actions in this controller.
  before_action :set_user

  # GET /users/:user_id/categories
  def index
    # Retrieves all categories and assigns them to the instance variable @categories.
    @categories = Category.includes(:expenses).all
    @category_totals = {}

    @categories.each do |category|
      @category_id = category.id
      @expenses = @user.expenses.includes(:category).where(category: @category_id)
      @category_totals[@category_id] = @expenses.sum(:amount)
    end
  end


  # GET /users/:user_id/categories/new
  def new
    # Initializes a new category instance to be used in the 'new' view.
    @category = Category.new
  end

  # POST /users/:user_id/categories
  def create
    # Builds a new category associated with the current user and populates it with the submitted parameters.
    @category = @user.categories.new(category_params)

    # Saves the category and handles the redirection based on the outcome.
    if @category.save
      redirect_to user_categories_path(@user), notice: 'Category was successfully created.'
    else
      # If saving fails, renders the 'new' view to display error messages.
      render :new
    end
  end

  private

  # Defines the allowed parameters for category creation.
  def category_params
    params.require(:category).permit(:name, :icon)
  end

  # Finds the user based on the :user_id parameter from the request.
  def set_user
    @user = User.find(params[:user_id])
  end
end
