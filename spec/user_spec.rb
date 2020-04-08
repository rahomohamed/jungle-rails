require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "is valid with valid attributes" do
      user = User.create(name: "Raho", email: "raho@gmail.com", password: "123", password_confirmation: "123")
      expect(user.errors.full_messages).to be_empty
    end

    it "is invalid when password and password confirmation fields do not match" do
      user = User.create(name: "Raho", email: "raho@gmail.com", password: "123", password_confirmation: "password")
      expect(user.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
    end

    it "is invalid when password is not set" do
      user = User.create(name: "Raho", email: "raho@gmail.com", password_confirmation: "123")
      expect(user.errors.full_messages.first).to eq "Password can't be blank"
    end

    it "is invalid when password is less than 3 characters" do
      user = User.create(name: "Raho", email: "raho@gmail.com", password: "12")
      puts user.errors.full_messages.first
      expect(user.errors.full_messages.first).to eq "Password is too short (minimum is 3 characters)"
    end

    it "is invalid when email is not set" do
      user = User.create(name: "Raho", password: "123", password_confirmation: "123")
      expect(user.errors.full_messages.first).to eq "Email can't be blank"
    end

    it "is invalid when email is not unique" do
      user1 = User.create(name: "Raho", email: "test@gmail.com", password: "123")
      user2 = User.create(name: "Raho", email: "test@gmail.com", password: "123")
      expect(user2.errors.full_messages.first).to eq "Email has already been taken"
    end

    it "it should have a valid name" do
      user = User.create(email: "raho@gmail.com", password: "123")
      puts (user.errors.full_messages.first)
      expect(user.errors.full_messages.first).to eq "Name can't be blank"
    end
  end

  describe '.authenticate_with_credentials' do
    it "logs in successfully with correct credentials" do
      register = User.create(name: "Raho", email: "raho@gmail.com", password: "123", password_confirmation: "123")
      login = User.authenticate_with_credentials("raho@gmail.com", "123")
      expect(login).to_not be nil
    end

    it 'does not login with non existent email' do
      registerUser = User.create(name: "Raho", email: "raho@gmail.com", password: "123", password_confirmation: "123")
      loginUser = User.authenticate_with_credentials("asma@gmail.com", "Password")
      expect(loginUser).to be nil
    end

    it 'does not login with an incorrect password' do
      registerUser = User.create(name: "Raho", email: "raho@gmail.com", password: "123", password_confirmation: "123")
      loginUser = User.authenticate_with_credentials( "raho@gmail.com", "no")
      expect(loginUser).to be nil
    end

    it 'logs in with an email with extra spaces' do
      registerUser = User.create(name: "Raho", email: "raho@gmail.com", password: "123", password_confirmation: "123")
      loginUser = User.authenticate_with_credentials('  raho@gmail.com   ', '123')
      expect(loginUser).to_not be nil
    end

    it 'logs in with an email with different cases' do
      registerUser = User.create(name: "Raho", email: "raho@gmail.com", password: "123", password_confirmation: "123")
      loginUser = User.authenticate_with_credentials('rAhO@gmail.com', '123')
      expect(loginUser).to_not be nil
    end
  end
end