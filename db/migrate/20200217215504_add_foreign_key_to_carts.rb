class AddForeignKeyToCarts < ActiveRecord::Migration[6.0]
  def change
    add_reference :carts, :user, index: true, foreign_key: true
    add_reference :carts, :items, index: true, foreign_key: true
  end
end
