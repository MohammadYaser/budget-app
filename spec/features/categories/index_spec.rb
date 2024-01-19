require 'rails_helper'

RSpec.describe 'Testing Category#index view', type: :feature do
  before(:each) do
    # Creating a test user
    @user = User.create(name: 'Test User', email: 'example@test.com', password: '123456')

    # Creating test categories for the user
    @categories = [
      Category.create(name: 'Category 1', icon: 'icon1', user: @user),
      Category.create(name: 'Category 2', icon: 'icon2', user: @user)
    ]

    # Creating test expenses for each category
    Expense.create(category: @categories[0], amount: 100, created_at: Time.now - 1.day)
    Expense.create(category: @categories[0], amount: 150, created_at: Time.now)
    Expense.create(category: @categories[1], amount: 200, created_at: Time.now)

    # Assuming you have set up @category_totals in the controller
    # Manually set it here for the test
    @category_totals = {
      @categories[0].id => 250, # Set the correct total amount for each category
      @categories[1].id => 200
    }
  end

  it 'renders the category list with correct information' do
    # Visiting the user's category index page
    visit user_categories_path(@user)

    # Assertions for elements on the page
    expect(page).to have_selector('header h2', text: 'CATEGORIES')
    expect(page).to have_selector('header i.fa.fa-search')
    expect(page).to have_selector('.category-list')

    # Looping through each category and making assertions
    @categories.each do |category|
      expect(page).to have_selector('.category-link', count: @categories.length)

      # Using within to scope the assertions to the specific category link
      within(".category-link[href='#{user_category_expenses_path(@user, category)}']") do
        expect(page).to have_selector(".category-icon img[src=\"#{category.icon}\"]")
        expect(page).to have_selector('.category p', text: category.name)
        expect(page).to have_selector('.category p.expense-date', text: category.created_at.strftime('%m/%d/%Y'))

        # Updated assertion to check for the presence of a CSS class
        expect(page).to have_css('.category .amount p') # Adjust this selector accordingly
      end
    end
  end
end
