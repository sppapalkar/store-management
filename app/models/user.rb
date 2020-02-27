class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :date_of_birth, :phone, :email, :encrypted_password, :address,
            :city, :postal_code, presence: true
  has_many :cards
  has_many :orders
  has_many :carts
  has_many :wishlists
  def get_age
    ((Date.parse(Time.now.strftime("%y/%m/%d")) - self.date_of_birth)/365).floor
  end
end
