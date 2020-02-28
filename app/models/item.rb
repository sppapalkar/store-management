class Item < ApplicationRecord
  validates :name, :brand, :price, :quantity, presence: true
  belongs_to :category
  mount_uploader :image, ItemsUploader

  def get_name
    "#{brand} #{name}"
  end
end
