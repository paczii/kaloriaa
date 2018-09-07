require 'rails_helper'

RSpec.describe "distances/show", type: :view do
  before(:each) do
    @distance = assign(:distance, Distance.create!(
      :from_id => 2,
      :to_id => 3,
      :traveltime => 4.5,
      :traveldistance => 5.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
  end
end
