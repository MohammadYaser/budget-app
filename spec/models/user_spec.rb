require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    # Creating a test user with valid attributes
    @user = User.create!(name: 'sadaf', email: 'test@example.com', password: 'f4k3p455w0rd')
  end

  it 'is valid with valid attributes' do
    # Expecting the user with valid attributes to be valid
    expect(@user).to be_valid
  end

  it 'is not valid without a name' do
    # Making the user name nil to test validation without a name
    @user.name = nil

    # Expecting the user to be invalid without a name
    expect(@user).to_not be_valid
  end

  it 'is not valid without an email' do
    # Making the user email nil to test validation without an email
    @user.email = nil

    # Expecting the user to be invalid without an email
    expect(@user).to_not be_valid
  end
end
