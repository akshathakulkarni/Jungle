require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should have password and password_confirmation fields' do
      @user = User.new(:name => 'abc', :email => 'abc@gmail.com', :password => 'abc@123', :password_confirmation => 'abc@123')
      @user.save
      expect(@user.password).to be_present
      expect(@user.password_confirmation).to be_present
    end
    it 'password should match with password_confirmation' do
      @user = User.new(:name => 'abc', :email => 'abc@gmail.com', :password => 'abc@123', :password_confirmation => 'abc@123')
      @user.save
      expect(@user.password).to match (@user.password_confirmation) 
    end
    it 'password should not match with password_confirmation' do
      @user = User.new(:name => 'abc', :email => 'abc@gmail.com', :password => 'abc@123', :password_confirmation => '123@123')
      @user.save
      expect(@user.password).not_to match (@user.password_confirmation) 
    end
    it 'should validate uniqueness of email that are case_sensitive' do
      @user = User.new(:name => 'efg', :email => 'efg@gmail.com', :password => 'efg@123', :password_confirmation => 'efg@123')
      @user.save
      @user2 = User.new(:name => 'abc', :email => 'EFG@gmail.com', :password => 'abc@123', :password_confirmation => 'abc@123')
      expect(@user2).to_not be_valid
    end
    it 'should have an email' do
      @user = User.new(:name => 'efg', :email => 'xyz@gmail.com', :password => 'efg@123', :password_confirmation => 'efg@123')
      @user.save
      expect(@user.email).to be_present
    end
    it 'should not save the user when email is nil' do
      @user = User.new(:name => 'efg', :email => nil, :password => 'efg@123', :password_confirmation => 'efg@123')
      @user.save
      expect(@user.email).to_not be_present
    end
    it 'should have a name' do
      @user = User.new(:name => 'efg', :email => 'efg@gmail.com', :password => 'efg@123', :password_confirmation => 'efg@123')
      @user.save
      expect(@user.name).to be_present
    end
    it 'should not save the user when name is nil' do
      @user = User.new(:name => nil, :email => 'xyz@gmail.com', :password => 'efg@123', :password_confirmation => 'efg@123')
      @user.save
      expect(@user).to_not be_valid
    end
    it 'should have a password with minimum length' do
      @user = User.new(:name => 'abc', :email => 'xyz@gmail.com', :password => 'ef3', :password_confirmation => 'ef3')
      @user.save
      expect(@user).to be_valid
    end
    it 'should not be valid when the password does not meet minimum length' do
      @user = User.new(:name => 'abc', :email => 'xyz@gmail.com', :password => 'ef', :password_confirmation => 'ef')
      @user.save
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentails' do
    it 'should return the user if successfully authenticated' do
      user1 = User.new(:name => 'abc', :email => 'abc@gmail.com', :password => 'abc@123', :password_confirmation => 'abc@123')
      user1.save
      @user = User.authenticate_with_credentials('abc@gmail.com', 'abc@123')
      expect(@user).to be_present
    end
    it 'should return nil if the user is not authenticated' do
      user1 = User.new(:name => 'abc', :email => 'abc@gmail.com', :password => 'abc@123', :password_confirmation => 'abc@123')
      user1.save
      @user = User.authenticate_with_credentials('abc@gmail.com', 'xyz@123')
      expect(@user).to be_nil
    end
    it 'should allow the user to login even when all the letters in email are uppercase' do
      user1 = User.new(:name => 'abc', :email => 'abc@gmail.com', :password => 'abc@123', :password_confirmation => 'abc@123')
      user1.save
      @user = User.authenticate_with_credentials('ABC@gmail.com', 'abc@123')
      expect(@user).to be_present
    end
    it 'should allow the user to login when there is space before or after email' do
      user1 = User.new(:name => 'abc', :email => 'abc@gmail.com', :password => 'abc@123', :password_confirmation => 'abc@123')
      user1.save
      @user = User.authenticate_with_credentials(' abc@gmail.com', 'abc@123')
      expect(@user).to be_present
    end
  end
end