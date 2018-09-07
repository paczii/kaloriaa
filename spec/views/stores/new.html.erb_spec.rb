require 'rails_helper'

RSpec.describe "stores/new", type: :view do
  before(:each) do
    assign(:store, Store.new(
      :name => "MyString",
      :city => "MyString",
      :street => "MyString",
      :zip => 1,
      :concept => 1,
      :area => "MyString"
    ))
  end

  it "renders new store form" do
    render

    assert_select "form[action=?][method=?]", stores_path, "post" do

      assert_select "input#store_name[name=?]", "store[name]"

      assert_select "input#store_city[name=?]", "store[city]"

      assert_select "input#store_street[name=?]", "store[street]"

      assert_select "input#store_zip[name=?]", "store[zip]"

      assert_select "input#store_concept[name=?]", "store[concept]"

      assert_select "input#store_area[name=?]", "store[area]"
    end
  end
end
