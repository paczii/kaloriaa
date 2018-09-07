require 'rails_helper'

RSpec.describe "customers/index", type: :view do
  before(:each) do
    assign(:customers, [
      Customer.create!(
        :user_id => 2,
        :name => "Name",
        :city => "City",
        :street => "Street",
        :zip => 3,
        :costmodel => 4,
        :favorites => "Favorites",
        :workcity => "Workcity",
        :workstreet => "Workstreet",
        :workzip => 5
      ),
      Customer.create!(
        :user_id => 2,
        :name => "Name",
        :city => "City",
        :street => "Street",
        :zip => 3,
        :costmodel => 4,
        :favorites => "Favorites",
        :workcity => "Workcity",
        :workstreet => "Workstreet",
        :workzip => 5
      )
    ])
  end

  it "renders a list of customers" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Favorites".to_s, :count => 2
    assert_select "tr>td", :text => "Workcity".to_s, :count => 2
    assert_select "tr>td", :text => "Workstreet".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
