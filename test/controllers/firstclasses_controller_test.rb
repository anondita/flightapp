require 'test_helper'

class FirstclassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @firstclass = firstclasses(:one)
  end

  test "should get index" do
    get firstclasses_url
    assert_response :success
  end

  test "should get new" do
    get new_firstclass_url
    assert_response :success
  end

  test "should create firstclass" do
    assert_difference('Firstclass.count') do
      post firstclasses_url, params: { firstclass: { emergency: @firstclass.emergency, price: @firstclass.price, row: @firstclass.row, seat: @firstclass.seat, total: @firstclass.total } }
    end

    assert_redirected_to firstclass_url(Firstclass.last)
  end

  test "should show firstclass" do
    get firstclass_url(@firstclass)
    assert_response :success
  end

  test "should get edit" do
    get edit_firstclass_url(@firstclass)
    assert_response :success
  end

  test "should update firstclass" do
    patch firstclass_url(@firstclass), params: { firstclass: { emergency: @firstclass.emergency, price: @firstclass.price, row: @firstclass.row, seat: @firstclass.seat, total: @firstclass.total } }
    assert_redirected_to firstclass_url(@firstclass)
  end

  test "should destroy firstclass" do
    assert_difference('Firstclass.count', -1) do
      delete firstclass_url(@firstclass)
    end

    assert_redirected_to firstclasses_url
  end
end
