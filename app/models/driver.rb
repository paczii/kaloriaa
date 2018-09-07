class Driver < ActiveRecord::Base
  belongs_to :store
  has_many :routes, dependent: :destroy
  has_one :vehicle
  validates :name, uniqueness: true

  has_many :orders, foreign_key: "allocateddriver", primary_key: "allocateddriver"

  has_many :directions
end
