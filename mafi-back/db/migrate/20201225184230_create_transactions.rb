class CreateTransactions < ActiveRecord::Migration[6.1]
  def change

    create_table :transaction_types, id: :string do |t|
      t.string :desc, null: false
    end

    create_table :transaction_statuses, id: :string do |t|
      t.string :desc, null: false
    end

    create_table :transaction_status_histories, id: :uuid do |t|
      t.uuid :transaction_id, null: false
      t.string :from_status_id, null: false
      t.string :to_status_id, null: false
      t.string :reason, null: true
      t.datetime :created_at, null: false
    end
    add_foreign_key :transaction_status_histories, :transaction_statuses, column: :from_status_id, primary_key: :id
    add_foreign_key :transaction_status_histories, :transaction_statuses, column: :to_status_id, primary_key: :id

    create_table :transaction_peer_types, id: :string do |t|
      t.string :desc, null: false
    end

    create_table :transaction_peers, id: :uuid do |t|
      t.string :type_id, null: false
      t.uuid :inner_account_id, null: true
      t.uuid :bank_detail_id, null: true
    end
    add_foreign_key :transaction_peers, :transaction_peer_types, column: :type_id, primary_key: :id
    add_foreign_key :transaction_peers, :accounts, column: :bank_detail_id, primary_key: :id

    create_table :transactions, id: :uuid do |t|
      t.float :amount, null: false
      t.string :currency_id, null: false
      t.uuid :from_id, null: false
      t.uuid :to_id, null: false
      t.string :type_id, null: false
      t.string :status_id, null: false
      t.uuid :parent_id, null: true
      t.datetime :executed_at, null: false
      t.timestamps
    end
    add_foreign_key :transactions, :transaction_peers, column: :from_id, primary_key: :id
    add_foreign_key :transactions, :transaction_peers, column: :to_id, primary_key: :id
    add_foreign_key :transactions, :transaction_peer_types, column: :type_id, primary_key: :id
    add_foreign_key :transactions, :transaction_statuses, column: :status_id, primary_key: :id
    add_foreign_key :transactions, :transactions, column: :parent_id, primary_key: :id

  end
end
