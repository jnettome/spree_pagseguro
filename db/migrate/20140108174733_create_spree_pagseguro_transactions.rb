class CreateSpreePagseguroTransactions < ActiveRecord::Migration
  def change
    create_table :spree_pagseguro_transactions do |t|
      t.string :email
      t.float :amount
      t.string :transaction_id
      t.string :customer_id
      t.string :order_id
      t.string :payment_id
      t.text :params
      t.string :code
      t.string :status

      t.timestamps
    end
  end
end
