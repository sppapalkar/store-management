class AddForeignKeyToCarts < ActiveRecord::Migration[6.0]
  def self.up
    add_reference :carts, :user, index: true, foreign_key: true
    add_reference :carts, :item, index: true, foreign_key: true
  end
  def self.down
    remove_reference :carts, :user, index: true, foreign_key: true
    remove_reference :carts, :item, index: true, foreign_key: true
  end
end
