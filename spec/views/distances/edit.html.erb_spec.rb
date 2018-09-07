require 'rails_helper'

RSpec.describe "distances/edit", type: :view do
  before(:each) do
    @distance = assign(:distance, Distance.create!(
      :from_id => 1,
      :to_id => 1,
      :traveltime => 1.5,
      :traveldistance => 1.5
    ))
  end

  it "renders the edit distance form" do
    render

    assert_select "form[action=?][method=?]", distance_path(@distance), "post" do

      assert_select "input#distance_from_id[name=?]", "distance[from_id]"

      assert_select "input#distance_to_id[name=?]", "distance[to_id]"

      assert_select "input#distance_traveltime[name=?]", "distance[traveltime]"

      assert_select "input#distance_traveldistance[name=?]", "distance[traveldistance]"
    end
  end
end
