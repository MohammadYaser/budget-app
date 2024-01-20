require 'rails_helper'

RSpec.describe Expense, type: :model do
  # Creating a test user for expense associations
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password123') }

  # Creating a test category for expense associations
  let(:category) { Category.create(name: 'Food') }

  it 'is valid with valid attributes' do
    # Creating an expense with valid attributes
    expense = Expense.new(
      name: 'Groceries',
      amount: 50.00,
      author_id: user.id,
      category: category # Associating the expense with the test category
    )

    # Expecting the expense to be valid
    expect(expense).to be_valid
  end

  it 'is not valid without a name' do
    # Creating an expense without a name
    expense = Expense.new(
      amount: 50.00,
      author_id: user.id,
      category: category # Associating the expense with the test category
    )

    # Expecting the expense to be invalid without a name
    expect(expense).to_not be_valid
  end

  it 'is not valid without an amount' do
    # Creating an expense without an amount
    expense = Expense.new(
      name: 'Groceries',
      author_id: user.id,
      category: category # Associating the expense with the test category
    )

    # Expecting the expense to be invalid without an amount
    expect(expense).to_not be_valid
  end

  it 'is not valid without an author_id' do
    # Creating an expense without an author_id
    expense = Expense.new(
      name: 'Groceries',
      amount: 50.00,
      category: category # Associating the expense with the test category
    )

    # Expecting the expense to be invalid without an author_id
    expect(expense).to_not be_valid
  end
end
