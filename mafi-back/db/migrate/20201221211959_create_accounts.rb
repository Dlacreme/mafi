class CreateAccounts < ActiveRecord::Migration[6.1]
  def change

    create_table :currencies, id: :string do |t|
      t.string :label, null: false
    end

    create_table :accounts, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.string :currency_id, null: false
      t.string :title, null: false
      t.float :balance, null: false, default: 0
      t.uuid :last_transaction_id, null: false

      t.datetime :disabled_at
      t.timestamps
    end
    add_foreign_key :accounts, :users
    add_foreign_key :accounts, :currencies
  end
end
