class User < ActiveRecord::Base
	has_many :catchcards
	
  has_secure_password

  validates :first_name, :last_name, :email, :wild_id, presence: true
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, format: {with: email_regex}, uniqueness: { case_sensitive: false }
end
