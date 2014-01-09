require 'spec_helper'

describe User do
  subject(:user) { build(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it 'is invalid without username' do
    user.username = nil
    expect(user).to be_invalid
  end

  it 'is invalid without username' do
    user.username = nil
    expect(user).to be_invalid
  end

  it 'has password salt and password hash after encryption' do
    expect(user.password_salt).to_not be_present
    user.encrypt_password()
    expect(user.password_salt).to be_present
    expect(user.password_salt).to be_present
  end
end
