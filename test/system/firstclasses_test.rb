require "application_system_test_case"

class FirstclassesTest < ApplicationSystemTestCase
  setup do
    @firstclass = firstclasses(:one)
  end

  test "visiting the index" do
    visit firstclasses_url
    assert_selector "h1", text: "Firstclasses"
  end

  test "creating a Firstclass" do
    visit firstclasses_url
    click_on "New Firstclass"

    fill_in "Emergency", with: @firstclass.emergency
    fill_in "Price", with: @firstclass.price
    fill_in "Row", with: @firstclass.row
    fill_in "Seat", with: @firstclass.seat
    fill_in "Total", with: @firstclass.total
    click_on "Create Firstclass"

    assert_text "Firstclass was successfully created"
    click_on "Back"
  end

  test "updating a Firstclass" do
    visit firstclasses_url
    click_on "Edit", match: :first

    fill_in "Emergency", with: @firstclass.emergency
    fill_in "Price", with: @firstclass.price
    fill_in "Row", with: @firstclass.row
    fill_in "Seat", with: @firstclass.seat
    fill_in "Total", with: @firstclass.total
    click_on "Update Firstclass"

    assert_text "Firstclass was successfully updated"
    click_on "Back"
  end

  test "destroying a Firstclass" do
    visit firstclasses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Firstclass was successfully destroyed"
  end
end
