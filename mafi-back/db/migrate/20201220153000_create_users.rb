# typed: true
class CreateUsers < ActiveRecord::Migration[6.1]
  def change

    create_table :roles, id: :string do |t|
    end

    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :role_id, null: false, default: "user"

      t.timestamps
    end

    add_foreign_key :users, :roles
  end
end
