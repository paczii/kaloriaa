require 'rails_helper'

RSpec.describe "distances/new", type: :view do
  before(:each) do
    assign(:distance, Distance.new(
      :from_id => 1,
      :to_id => 1,
      :traveltime => 1.5,
      :traveldistance => 1.5
    ))
  end

  it "renders new distance form" do
    render

    assert_select "form[action=?][method=?]", distances_path, "post" do

      assert_select "input#distance_from_id[name=?]", "distance[from_id]"

      assert_select "input#distance_to_id[name=?]", "distance[to_id]"

      assert_select "input#distance_traveltime[name=?]", "distance[traveltime]"

      assert_select "input#distance_traveldistance[name=?]", "distance[traveldistance]"
    end
  end
end
