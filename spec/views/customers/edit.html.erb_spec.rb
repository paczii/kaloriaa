require 'rails_helper'

RSpec.describe "customers/edit", type: :view do
  before(:each) do
    @customer = assign(:customer, Customer.create!(
      :user_id => 1,
      :name => "MyString",
      :city => "MyString",
      :street => "MyString",
      :zip => 1,
      :costmodel => 1,
      :favorites => "MyString",
      :workcity => "MyString",
      :workstreet => "MyString",
      :workzip => 1
    ))
  end

  it "renders the edit customer form" do
    render

    assert_select "form[action=?][method=?]", customer_path(@customer), "post" do

      assert_select "input#customer_user_id[name=?]", "customer[user_id]"

      assert_select "input#customer_name[name=?]", "customer[name]"

      assert_select "input#customer_city[name=?]", "customer[city]"

      assert_select "input#customer_street[name=?]", "customer[street]"

      assert_select "input#customer_zip[name=?]", "customer[zip]"

      assert_select "input#customer_costmodel[name=?]", "customer[costmodel]"

      assert_select "input#customer_favorites[name=?]", "customer[favorites]"

      assert_select "input#customer_workcity[name=?]", "customer[workcity]"

      assert_select "input#customer_workstreet[name=?]", "customer[workstreet]"

      assert_select "input#customer_workzip[name=?]", "customer[workzip]"
    end
  end
end
