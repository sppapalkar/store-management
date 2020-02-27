class Item < ApplicationRecord
  validates :name, presence: true
  belongs_to :category
  mount_uploader :image, ItemsUploader

  def get_name
    "#{brand} #{name}"
  end
end
