class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.string :title, null: false
      t.datetime :disabled_at
      t.timestamps
    end

    add_foreign_key :accounts, :users
  end
end
