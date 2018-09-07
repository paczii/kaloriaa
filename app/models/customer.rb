class Customer < ActiveRecord::Base
  belongs_to :user
  has_many :carts, dependent: :destroy
  has_many :orders

  has_many :distances, foreign_key: "from_id", primary_key: "from_id"
  has_many :distances, foreign_key: "to_id", primary_key: "to_id"

  has_many :directions

end
