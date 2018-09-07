require 'test_helper'

class RoutesControllerTest < ActionController::TestCase
  setup do
    @route = routes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:routes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create route" do
    assert_difference('Route.count') do
      post :create, route: { day: @route.day, driver_id: @route.driver_id, drivingcosts: @route.drivingcosts, optimization_id: @route.optimization_id, route: @route.route, totalcosts: @route.totalcosts, totalprofit: @route.totalprofit, traveldistance: @route.traveldistance, traveltime: @route.traveltime, worktimecosts: @route.worktimecosts }
    end

    assert_redirected_to route_path(assigns(:route))
  end

  test "should show route" do
    get :show, id: @route
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @route
    assert_response :success
  end

  test "should update route" do
    patch :update, id: @route, route: { day: @route.day, driver_id: @route.driver_id, drivingcosts: @route.drivingcosts, optimization_id: @route.optimization_id, route: @route.route, totalcosts: @route.totalcosts, totalprofit: @route.totalprofit, traveldistance: @route.traveldistance, traveltime: @route.traveltime, worktimecosts: @route.worktimecosts }
    assert_redirected_to route_path(assigns(:route))
  end

  test "should destroy route" do
    assert_difference('Route.count', -1) do
      delete :destroy, id: @route
    end

    assert_redirected_to routes_path
  end
end
