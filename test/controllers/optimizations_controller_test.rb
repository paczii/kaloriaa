require 'test_helper'

class OptimizationsControllerTest < ActionController::TestCase
  setup do
    @optimization = optimizations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:optimizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create optimization" do
    assert_difference('Optimization.count') do
      post :create, optimization: { allocation: @optimization.allocation, drivers: @optimization.drivers, drivingcosts: @optimization.drivingcosts, optimizationtype: @optimization.optimizationtype, orders: @optimization.orders, productcosts: @optimization.productcosts, profit: @optimization.profit, routes: @optimization.routes, totalboxes: @optimization.totalboxes, totalcoolingboxes: @optimization.totalcoolingboxes, totalcosts: @optimization.totalcosts, totaldistance: @optimization.totaldistance, totalfreezingboxes: @optimization.totalfreezingboxes, totaltraveltime: @optimization.totaltraveltime, turnover: @optimization.turnover, useddrivers: @optimization.useddrivers, usedstores: @optimization.usedstores, worktimecosts: @optimization.worktimecosts }
    end

    assert_redirected_to optimization_path(assigns(:optimization))
  end

  test "should show optimization" do
    get :show, id: @optimization
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @optimization
    assert_response :success
  end

  test "should update optimization" do
    patch :update, id: @optimization, optimization: { allocation: @optimization.allocation, drivers: @optimization.drivers, drivingcosts: @optimization.drivingcosts, optimizationtype: @optimization.optimizationtype, orders: @optimization.orders, productcosts: @optimization.productcosts, profit: @optimization.profit, routes: @optimization.routes, totalboxes: @optimization.totalboxes, totalcoolingboxes: @optimization.totalcoolingboxes, totalcosts: @optimization.totalcosts, totaldistance: @optimization.totaldistance, totalfreezingboxes: @optimization.totalfreezingboxes, totaltraveltime: @optimization.totaltraveltime, turnover: @optimization.turnover, useddrivers: @optimization.useddrivers, usedstores: @optimization.usedstores, worktimecosts: @optimization.worktimecosts }
    assert_redirected_to optimization_path(assigns(:optimization))
  end

  test "should destroy optimization" do
    assert_difference('Optimization.count', -1) do
      delete :destroy, id: @optimization
    end

    assert_redirected_to optimizations_path
  end
end
