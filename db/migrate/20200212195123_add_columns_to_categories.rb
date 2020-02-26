class AddColumnsToCategories < ActiveRecord::Migration[6.0]
  def self.up
    add_column :categories, :tax_slab, :decimal, null: false, default: 0.0
  end
  def self.down
    remove_column :categories, :tax_slab
  end
end
