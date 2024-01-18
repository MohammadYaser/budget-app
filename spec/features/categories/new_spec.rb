require 'rails_helper'

RSpec.describe 'Testing Category#new view', type: :feature do
  before(:each) do
    # Creating a test user for the scenarios
    @user = User.create(name: 'Test User', email: 'example@test.com', password: '123456')
  end

  it 'renders the new category form' do
    # Visiting the new category page for the user
    visit new_user_category_path(@user)

    # Assertions for the elements on the page
    expect(page).to have_selector('header h2', text: 'ADD CATEGORY')
    expect(page).to have_current_path(new_user_category_path(@user))
    expect(page).to have_field('category_name')
    expect(page).to have_field('category_icon')
    expect(page).to have_button('Save')
  end

  it 'creates a new category when the form is submitted' do
    # Visiting the new category page for the user
    visit new_user_category_path(@user)

    # Filling in the form fields and submitting the form
    fill_in 'category_name', with: 'Test Category'
    fill_in 'category_icon', with: 'test-icon'
    click_button 'Save'

    # Assertions for the successful category creation
    expect(page).to have_content('Category was successfully created.')
    
    # Checking the database for the newly created category
    expect(Category.last.name).to eq('Test Category')
    expect(Category.last.icon).to eq('test-icon')
  end
end
