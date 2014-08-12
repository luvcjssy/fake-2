class Account < ActiveRecord::Base
	validates :username, :password, :presence => true
end
