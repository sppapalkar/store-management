class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :amount
      t.decimal :discount
      t.decimal :tax
      t.timestamps
    end
  end
end
