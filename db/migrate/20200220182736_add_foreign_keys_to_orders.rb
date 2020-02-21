class AddForeignKeysToOrders < ActiveRecord::Migration[6.0]
  def self.up
    add_reference :orders, :user, index: true, foreign_key: true
    add_reference :orders, :card, index: true, foreign_key: true
  end
  def self.down
    remove_reference :orders, :user, index: true, foreign_key: true
    remove_reference :orders, :card, index: true, foreign_key: true
  end
end
