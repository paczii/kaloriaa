require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Day/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Products/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/6.5/)
    expect(rendered).to match(/7.5/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/Estimatedtime/)
    expect(rendered).to match(/10/)
  end
end
