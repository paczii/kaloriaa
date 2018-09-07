FactoryGirl.define do
  factory :order do
    customer_id 1
    method 1
    day "MyString"
    timewindow 1
    products "MyString"
    neededboxes 1.5
    neededcoolingboxes 1.5
    neededfreezingboxes 1.5
    allocatedstore 1
    allocateddriver 1
    estimatedtime "MyString"
    status 1
  end
end
