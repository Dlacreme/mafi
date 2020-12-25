# typed: false
class User < ApplicationRecord
  has_secure_password validations: false

  belongs_to :role
  has_many :accounts

  validates :email, presence: true, email: true, uniqueness: true

  before_create :process_register

  def to_j()
    self
      .attributes
      .except("password_digest")
  end

  def self.try_auth(email, password)
    return self.find_by(email: email).try(:authenticate, password)
  end

  def admin?
    return self.role_id == Roles::Admin
  end

  private
  def process_register
    p "Should send confirmation email here."
  end
end
