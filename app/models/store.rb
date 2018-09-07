class Store < ActiveRecord::Base
  has_many :stocks,  :dependent => :destroy
  has_many :drivers,  :dependent => :destroy

  has_many :distances, foreign_key: "from_id", primary_key: "from_id"
  has_many :distances, foreign_key: "to_id", primary_key: "to_id"

  has_many :orders, foreign_key: "allocatedstore", primary_key: "allocatedstore"

end
