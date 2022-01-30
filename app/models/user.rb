class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: { minimum: 3 }
  # before_save { self.email.downcase! }

   def downcase_fields
      self.email.downcase!
   end

   def remove_space
      self.email.squish
   end
  
  def self.authenticate_with_credentials(email, password)
    if email == email.upcase! 
      correct_email = email.downcase!
    else
      correct_email = email
    end
    # Use squish to remove white spaces if any
    @user = User.find_by email:correct_email.squish 
    if @user.authenticate(password)
      @user
    else
      nil
    end
  end
end
