class User < ApplicationRecord
  include ModuleTrimSpaceName

  acts_as_paranoid

  attr_accessor :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest

  PASSWORD_EXPIRED_TIME = 1
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  attr_accessor :reset_token

  has_secure_password

  has_many :results, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50, minimum: 3 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true,
                       confirmation: true

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute :reset_digest,  User.digest(reset_token)
    update_attribute :reset_send_at, Time.zone.now
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def password_reset_expired?
    reset_send_at < PASSWORD_EXPIRED_TIME.hours.ago
  end

  class << self
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
