require 'test_helper'

class AirplanesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @airplane = airplanes(:one)
  end

  test "should get index" do
    get airplanes_url
    assert_response :success
  end

  test "should get new" do
    get new_airplane_url
    assert_response :success
  end

  test "should create airplane" do
    assert_difference('Airplane.count') do
      post airplanes_url, params: { airplane: { busemer: @airplane.busemer, busprice: @airplane.busprice, busrow: @airplane.busrow, busseat: @airplane.busseat, ecoemer: @airplane.ecoemer, ecoprice: @airplane.ecoprice, ecorow: @airplane.ecorow, ecoseat: @airplane.ecoseat, firstemer: @airplane.firstemer, firstprice: @airplane.firstprice, firstrow: @airplane.firstrow, firstseat: @airplane.firstseat, name: @airplane.name, type: @airplane.type } }
    end

    assert_redirected_to airplane_url(Airplane.last)
  end

  test "should show airplane" do
    get airplane_url(@airplane)
    assert_response :success
  end

  test "should get edit" do
    get edit_airplane_url(@airplane)
    assert_response :success
  end

  test "should update airplane" do
    patch airplane_url(@airplane), params: { airplane: { busemer: @airplane.busemer, busprice: @airplane.busprice, busrow: @airplane.busrow, busseat: @airplane.busseat, ecoemer: @airplane.ecoemer, ecoprice: @airplane.ecoprice, ecorow: @airplane.ecorow, ecoseat: @airplane.ecoseat, firstemer: @airplane.firstemer, firstprice: @airplane.firstprice, firstrow: @airplane.firstrow, firstseat: @airplane.firstseat, name: @airplane.name, type: @airplane.type } }
    assert_redirected_to airplane_url(@airplane)
  end

  test "should destroy airplane" do
    assert_difference('Airplane.count', -1) do
      delete airplane_url(@airplane)
    end

    assert_redirected_to airplanes_url
  end
end
