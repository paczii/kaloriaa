class Route < ActiveRecord::Base
  belongs_to :driver
  belongs_to :optimization
end
