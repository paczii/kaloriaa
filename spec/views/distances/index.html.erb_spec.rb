require 'rails_helper'

RSpec.describe "distances/index", type: :view do
  before(:each) do
    assign(:distances, [
      Distance.create!(
        :from_id => 2,
        :to_id => 3,
        :traveltime => 4.5,
        :traveldistance => 5.5
      ),
      Distance.create!(
        :from_id => 2,
        :to_id => 3,
        :traveltime => 4.5,
        :traveldistance => 5.5
      )
    ])
  end

  it "renders a list of distances" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
  end
end
