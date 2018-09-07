require 'rails_helper'

RSpec.describe "customers/show", type: :view do
  before(:each) do
    @customer = assign(:customer, Customer.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Street/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Favorites/)
    expect(rendered).to match(/Workcity/)
    expect(rendered).to match(/Workstreet/)
    expect(rendered).to match(/5/)
  end
end
