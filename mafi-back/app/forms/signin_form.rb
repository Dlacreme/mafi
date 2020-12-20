class SigninForm < Reform::Form

  property :email
  property :password

  validates :email,       presence: true, email: true

  validates_uniqueness_of :email
end
