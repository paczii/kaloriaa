class Product < ActiveRecord::Base
  has_many :stocks,  :dependent => :destroy
  belongs_to :order
end
