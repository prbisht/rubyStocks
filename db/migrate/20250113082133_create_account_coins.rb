class CreateAccountCoins < ActiveRecord::Migration[7.2]
  def change
    create_table :account_coins do |t|
      t.string :coin_name, null: false
      t.decimal :quantity, precision: 20, scale: 2, default: "0.0", null: false
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end
