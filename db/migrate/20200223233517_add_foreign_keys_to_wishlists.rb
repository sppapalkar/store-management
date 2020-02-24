class AddForeignKeysToWishlists < ActiveRecord::Migration[6.0]
  def self.up
    add_reference :wishlists, :user, index: true, foreign_key: true
    add_reference :wishlists, :item, index: true, foreign_key: true
  end
  def self.down
    remove_reference :wishlists, :user, index: true, foreign_key: true
    remove_reference :wishlists, :item, index: true, foreign_key: true
  end
end
