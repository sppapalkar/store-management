class AddColumnToOrderitems < ActiveRecord::Migration[6.0]
  def self.up
    add_column :orderitems, :status, :string, null: false, default: 'Complete'
  end
  def self.down
    remove_column :orderitems, :status
  end
end
