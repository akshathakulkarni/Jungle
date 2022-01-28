class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: { minimum: 3 }
  
  def authenticate_with_credentials(email, password)
    if user.authenticate(email, password)
      @user
    else
      nil
    end
  end

  
end
