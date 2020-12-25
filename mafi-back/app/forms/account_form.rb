class AccountForm < Reform::Form
  property :title
  property :user_id
  validates :title, presence: true
  validates :user_id, presence: true
end