require 'test_helper'

class EconomiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @economy = economies(:one)
  end

  test "should get index" do
    get economies_url
    assert_response :success
  end

  test "should get new" do
    get new_economy_url
    assert_response :success
  end

  test "should create economy" do
    assert_difference('Economy.count') do
      post economies_url, params: { economy: { emergency: @economy.emergency, price: @economy.price, row: @economy.row, seat: @economy.seat, total: @economy.total } }
    end

    assert_redirected_to economy_url(Economy.last)
  end

  test "should show economy" do
    get economy_url(@economy)
    assert_response :success
  end

  test "should get edit" do
    get edit_economy_url(@economy)
    assert_response :success
  end

  test "should update economy" do
    patch economy_url(@economy), params: { economy: { emergency: @economy.emergency, price: @economy.price, row: @economy.row, seat: @economy.seat, total: @economy.total } }
    assert_redirected_to economy_url(@economy)
  end

  test "should destroy economy" do
    assert_difference('Economy.count', -1) do
      delete economy_url(@economy)
    end

    assert_redirected_to economies_url
  end
end
