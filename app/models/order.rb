class Order < ApplicationRecord
  belongs_to :user
  has_many :orderitems, dependent: :delete_all
  has_one :card
end