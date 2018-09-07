require 'rails_helper'

RSpec.describe "vehicles/index", type: :view do
  before(:each) do
    assign(:vehicles, [
      Vehicle.create!(
        :name => "Name",
        :range => 2.5,
        :emissions => 3.5,
        :speed => 4.5,
        :boxcapacity => 5.5,
        :coolingboxcapacity => 6.5,
        :freezingboxcapacity => 7.5,
        :capacity => 8.5
      ),
      Vehicle.create!(
        :name => "Name",
        :range => 2.5,
        :emissions => 3.5,
        :speed => 4.5,
        :boxcapacity => 5.5,
        :coolingboxcapacity => 6.5,
        :freezingboxcapacity => 7.5,
        :capacity => 8.5
      )
    ])
  end

  it "renders a list of vehicles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
    assert_select "tr>td", :text => 8.5.to_s, :count => 2
  end
end
