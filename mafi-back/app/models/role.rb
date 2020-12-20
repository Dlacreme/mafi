# typed: strict
class Role < ApplicationRecord
  has_many :users
end
