class AddColumnsToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :tax_slab, :decimal
    change_column :categories, :tax_slab, :decimal, null: false, default: ''
  end
end
