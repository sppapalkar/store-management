class AddForeignKeysToOrderitems < ActiveRecord::Migration[6.0]
  def self.up
    add_reference :orderitems, :order, index: true, foreign_key: true
  end
  def self.down
    remove_reference :orderitems, :order, index: true, foreign_key: true
  end
end
