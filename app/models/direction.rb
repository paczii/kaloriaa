class Direction < ActiveRecord::Base

  belongs_to :optimization
  belongs_to :customer
  belongs_to :driver


end
