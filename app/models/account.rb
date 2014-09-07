class Account < ActiveRecord::Base
	#attr_asscessible :email, :password, :password_confirmation
	has_many :images
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX }
	validates :password, :length => {in: 6..20}
	validates_confirmation_of :password
	validates_presence_of :password
  	validates_presence_of :email
  	validates_uniqueness_of :email
	
	before_save :encrypt_password

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.password = BCrypt::Engine.hash_secret(password, salt)
		end
	end

	def self.authenticate(email, password)
		account = Account.find_by_email(email)
		if account && account.password == BCrypt::Engine.hash_secret(password, account.salt)
			account
		else
			nil
		end
	end
	
end
