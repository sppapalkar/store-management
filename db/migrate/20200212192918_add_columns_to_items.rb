class AddColumnsToItems < ActiveRecord::Migration[6.0]
  def self.up
    add_column :items, :brand, :string, null: false, default: ''
    add_column :items, :restricted_item, :boolean, null:false, default: false
    add_column :items, :age_restricted_item, :boolean, null:false, default: false
    add_column :items, :quantity, :integer, null:false, default: 0
    add_column :items, :price, :decimal, null: false, default: 0.0
    add_column :items, :popularity, :decimal, null:false, default: 1.0
  end
  def self.down
    remove_column :items, :brand
    remove_column :items, :restricted_item
    remove_column :items, :age_restricted_item
    remove_column :items, :quantity
    remove_column :items, :price
    remove_column :items, :popularity
  end
end
