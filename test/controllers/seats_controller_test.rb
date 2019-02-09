require 'test_helper'

class SeatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @seat = seats(:one)
  end

  test "should get index" do
    get seats_url
    assert_response :success
  end

  test "should get new" do
    get new_seat_url
    assert_response :success
  end

  test "should create seat" do
    assert_difference('Seat.count') do
      post seats_url, params: { seat: { booking_id: @seat.booking_id, flight_id: @seat.flight_id, pnr: @seat.pnr, price: @seat.price, seatclass: @seat.seatclass, seatnumber: @seat.seatnumber, seattype: @seat.seattype } }
    end

    assert_redirected_to seat_url(Seat.last)
  end

  test "should show seat" do
    get seat_url(@seat)
    assert_response :success
  end

  test "should get edit" do
    get edit_seat_url(@seat)
    assert_response :success
  end

  test "should update seat" do
    patch seat_url(@seat), params: { seat: { booking_id: @seat.booking_id, flight_id: @seat.flight_id, pnr: @seat.pnr, price: @seat.price, seatclass: @seat.seatclass, seatnumber: @seat.seatnumber, seattype: @seat.seattype } }
    assert_redirected_to seat_url(@seat)
  end

  test "should destroy seat" do
    assert_difference('Seat.count', -1) do
      delete seat_url(@seat)
    end

    assert_redirected_to seats_url
  end
end
