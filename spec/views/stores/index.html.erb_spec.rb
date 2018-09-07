require 'rails_helper'

RSpec.describe "stores/index", type: :view do
  before(:each) do
    assign(:stores, [
      Store.create!(
        :name => "Name",
        :city => "City",
        :street => "Street",
        :zip => 2,
        :concept => 3,
        :area => "Area"
      ),
      Store.create!(
        :name => "Name",
        :city => "City",
        :street => "Street",
        :zip => 2,
        :concept => 3,
        :area => "Area"
      )
    ])
  end

  it "renders a list of stores" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Area".to_s, :count => 2
  end
end
