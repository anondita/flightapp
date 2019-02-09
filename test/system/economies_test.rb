require "application_system_test_case"

class EconomiesTest < ApplicationSystemTestCase
  setup do
    @economy = economies(:one)
  end

  test "visiting the index" do
    visit economies_url
    assert_selector "h1", text: "Economies"
  end

  test "creating a Economy" do
    visit economies_url
    click_on "New Economy"

    fill_in "Emergency", with: @economy.emergency
    fill_in "Price", with: @economy.price
    fill_in "Row", with: @economy.row
    fill_in "Seat", with: @economy.seat
    fill_in "Total", with: @economy.total
    click_on "Create Economy"

    assert_text "Economy was successfully created"
    click_on "Back"
  end

  test "updating a Economy" do
    visit economies_url
    click_on "Edit", match: :first

    fill_in "Emergency", with: @economy.emergency
    fill_in "Price", with: @economy.price
    fill_in "Row", with: @economy.row
    fill_in "Seat", with: @economy.seat
    fill_in "Total", with: @economy.total
    click_on "Update Economy"

    assert_text "Economy was successfully updated"
    click_on "Back"
  end

  test "destroying a Economy" do
    visit economies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Economy was successfully destroyed"
  end
end
