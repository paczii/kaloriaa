require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      :customer_id => 1,
      :method => 1,
      :day => "MyString",
      :timewindow => 1,
      :products => "MyString",
      :neededboxes => 1.5,
      :neededcoolingboxes => 1.5,
      :neededfreezingboxes => 1.5,
      :allocatedstore => 1,
      :allocateddriver => 1,
      :estimatedtime => "MyString",
      :status => 1
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input#order_customer_id[name=?]", "order[customer_id]"

      assert_select "input#order_method[name=?]", "order[method]"

      assert_select "input#order_day[name=?]", "order[day]"

      assert_select "input#order_timewindow[name=?]", "order[timewindow]"

      assert_select "input#order_products[name=?]", "order[products]"

      assert_select "input#order_neededboxes[name=?]", "order[neededboxes]"

      assert_select "input#order_neededcoolingboxes[name=?]", "order[neededcoolingboxes]"

      assert_select "input#order_neededfreezingboxes[name=?]", "order[neededfreezingboxes]"

      assert_select "input#order_allocatedstore[name=?]", "order[allocatedstore]"

      assert_select "input#order_allocateddriver[name=?]", "order[allocateddriver]"

      assert_select "input#order_estimatedtime[name=?]", "order[estimatedtime]"

      assert_select "input#order_status[name=?]", "order[status]"
    end
  end
end
