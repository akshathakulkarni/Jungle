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
    it 'should have an email' do
      @user = User.new(:name => 'efg', :email => nil, :password => 'efg@123', :password_confirmation => 'efg@123')
      @user.save
      expect(@user.email).to_not be_present
    end
    it 'should have a name' do
      @user = User.new(:name => 'efg', :email => nil, :password => 'efg@123', :password_confirmation => 'efg@123')
      @user.save
      expect(@user.name).to be_present
    end
    it 'should have a name' do
      @user = User.new(:name => nil, :email => 'xyz@gmail.com', :password => 'efg@123', :password_confirmation => 'efg@123')
      @user.save
      expect(@user).to_not be_valid
    end
    it 'should have a password with minimum length' do
      @user = User.new(:name => 'abc', :email => 'xyz@gmail.com', :password => 'ef3', :password_confirmation => 'ef3')
      @user.save
      expect(@user).to be_valid
    end
    it 'should have a password with minimum length' do
      @user = User.new(:name => 'abc', :email => 'xyz@gmail.com', :password => 'ef', :password_confirmation => 'ef')
      @user.save
      expect(@user).to_not be_valid
    end
  end
end