class User < ActiveRecord::Base
  has_attached_file :image, default_url: "fly_trap.jpg"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :username, :email, :password_digest, :session_token, presence: true
  validates :username, :email, :session_token, uniqueness: true
  validates :activated, inclusion: [true, false]
  validates :password, length: {minimum: 6}, allow_nil: true



  before_validation :ensure_activation_token, on: :create
  after_initialize :ensure_session_token


  has_many :user_feeds, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :feeds, through: :user_feeds
  has_many :entries, through: :feeds
  has_many :user_read_entries, dependent: :destroy
  has_many :read_entries, through: :user_read_entries, source: :entry

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.has_password?(password) ? user : nil
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

  def ensure_activation_token
    self.activation_token || self.activation_token = SecureRandom.urlsafe_base64
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
