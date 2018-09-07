require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        :customer_id => 2,
        :method => 3,
        :day => "Day",
        :timewindow => 4,
        :products => "Products",
        :neededboxes => 5.5,
        :neededcoolingboxes => 6.5,
        :neededfreezingboxes => 7.5,
        :allocatedstore => 8,
        :allocateddriver => 9,
        :estimatedtime => "Estimatedtime",
        :status => 10
      ),
      Order.create!(
        :customer_id => 2,
        :method => 3,
        :day => "Day",
        :timewindow => 4,
        :products => "Products",
        :neededboxes => 5.5,
        :neededcoolingboxes => 6.5,
        :neededfreezingboxes => 7.5,
        :allocatedstore => 8,
        :allocateddriver => 9,
        :estimatedtime => "Estimatedtime",
        :status => 10
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Day".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Products".to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => "Estimatedtime".to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
  end
end
