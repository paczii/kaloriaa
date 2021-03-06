require 'rails_helper'

RSpec.describe "vehicles/new", type: :view do
  before(:each) do
    assign(:vehicle, Vehicle.new(
      :name => "MyString",
      :range => 1.5,
      :emissions => 1.5,
      :speed => 1.5,
      :boxcapacity => 1.5,
      :coolingboxcapacity => 1.5,
      :freezingboxcapacity => 1.5,
      :capacity => 1.5
    ))
  end

  it "renders new vehicle form" do
    render

    assert_select "form[action=?][method=?]", vehicles_path, "post" do

      assert_select "input#vehicle_name[name=?]", "vehicle[name]"

      assert_select "input#vehicle_range[name=?]", "vehicle[range]"

      assert_select "input#vehicle_emissions[name=?]", "vehicle[emissions]"

      assert_select "input#vehicle_speed[name=?]", "vehicle[speed]"

      assert_select "input#vehicle_boxcapacity[name=?]", "vehicle[boxcapacity]"

      assert_select "input#vehicle_coolingboxcapacity[name=?]", "vehicle[coolingboxcapacity]"

      assert_select "input#vehicle_freezingboxcapacity[name=?]", "vehicle[freezingboxcapacity]"

      assert_select "input#vehicle_capacity[name=?]", "vehicle[capacity]"
    end
  end
end
