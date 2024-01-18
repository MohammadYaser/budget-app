require 'rails_helper'

RSpec.describe Category, type: :model do
  # Creating a test user for category associations
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password123') }

  it 'is valid with valid attributes' do
    # Creating a category with valid attributes
    category = Category.new(
      name: 'Food',
      icon: '🍔',
      user: user # Associating the category with the test user
    )

    # Expecting the category to be valid
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    # Creating a category without a name
    category = Category.new(
      icon: '🍔',
      user: user # Associating the category with the test user
    )

    # Expecting the category to be invalid without a name
    expect(category).to_not be_valid
  end

  it 'is not valid without an icon' do
    # Creating a category without an icon
    category = Category.new(
      name: 'Food',
      user: user # Associating the category with the test user
    )

    # Expecting the category to be invalid without an icon
    expect(category).to_not be_valid
  end
end
