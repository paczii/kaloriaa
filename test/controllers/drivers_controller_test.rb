require 'test_helper'

class DriversControllerTest < ActionController::TestCase
  setup do
    @driver = drivers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:drivers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create driver" do
    assert_difference('Driver.count') do
      post :create, driver: { boxes: @driver.boxes, coolingboxes: @driver.coolingboxes, freezingboxes: @driver.freezingboxes, route: @driver.route, store_id: @driver.store_id, totaldistance: @driver.totaldistance, totalemissions: @driver.totalemissions, totaltraveltime: @driver.totaltraveltime, vehicle: @driver.vehicle }
    end

    assert_redirected_to driver_path(assigns(:driver))
  end

  test "should show driver" do
    get :show, id: @driver
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @driver
    assert_response :success
  end

  test "should update driver" do
    patch :update, id: @driver, driver: { boxes: @driver.boxes, coolingboxes: @driver.coolingboxes, freezingboxes: @driver.freezingboxes, route: @driver.route, store_id: @driver.store_id, totaldistance: @driver.totaldistance, totalemissions: @driver.totalemissions, totaltraveltime: @driver.totaltraveltime, vehicle: @driver.vehicle }
    assert_redirected_to driver_path(assigns(:driver))
  end

  test "should destroy driver" do
    assert_difference('Driver.count', -1) do
      delete :destroy, id: @driver
    end

    assert_redirected_to drivers_path
  end
end