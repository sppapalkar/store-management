class AddPriceColumntoItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :price, :decimal
    change_column :items, :price, :decimal , null: false, default: ''
    add_column :items, :popularity, :decimal
    change_column :items, :popularity, :decimal, null: false, default: 1.0
  end
end
