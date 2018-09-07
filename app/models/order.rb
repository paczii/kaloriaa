class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :driver
  belongs_to :store
  #belongs_to :optimization
  #has_many :products
end
