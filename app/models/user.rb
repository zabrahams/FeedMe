class User < ActiveRecord::Base
  validates :username, :email, :password_digest, :session_token, presence: true
  validates :activated, inclusion: [true, false]
  validates :password, length: {minimum: 6}, allow_nil: true

  attr_reader: password

end
