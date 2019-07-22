class User < ApplicationRecord
  PASSWORD_EXPIRED_TIME = 1
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :reset_token

  has_secure_password

  validates :name, presence: true, length: {maximum: 50, minimum: 3}
  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute :reset_digest,  User.digest(reset_token)
    update_attribute :reset_send_at, Time.zone.now
  end

  def authenticated? token
    return if reset_digest.nil?
    BCrypt::Password.new(reset_digest).is_password?(token)
  end

  def password_reset_expired?
    reset_send_at < PASSWORD_EXPIRED_TIME.hours.ago
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
