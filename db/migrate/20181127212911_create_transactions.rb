class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      enable_extension :citext
      
      t.references :invoice, foreign_key: true
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.citext :result

      t.timestamps
    end
  end
end
