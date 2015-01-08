class User < ActiveRecord::Base
  validates :username, :email, :password_digest, :session_token, presence: true
  validates :username, :email, :session_token, uniqueness: true
  validates :activated, inclusion: [true, false]
  validates :password, length: {minimum: 6}, allow_nil: true

  after_initialize :ensure_session_token

  has_many :user_feeds, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :feeds, through: :user_feeds
  has_many :entries, through: :feeds

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user.has_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def has_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token || self.session_token = unique_session_token
  end

  def reset_session_token!
    self.session_token = unique_session_token
    self.save!
  end

  def unique_session_token
    users = User.all # is there a way to do this while caching users?
    new_token = SecureRandom.urlsafe_base64
    until users.none { |user| user.session_token == new_token }
      new_token = SecureRandom.urlsafe_base64
    end

    new_token
  end

end
