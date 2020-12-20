# typed: true
class EnableUuid < ActiveRecord::Migration[6.1]
  def change
    # We will be using UUID as ID
    enable_extension 'pgcrypto'
  end
end
