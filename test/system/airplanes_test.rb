require "application_system_test_case"

class AirplanesTest < ApplicationSystemTestCase
  setup do
    @airplane = airplanes(:one)
  end

  test "visiting the index" do
    visit airplanes_url
    assert_selector "h1", text: "Airplanes"
  end

  test "creating a Airplane" do
    visit airplanes_url
    click_on "New Airplane"

    fill_in "Busemer", with: @airplane.busemer
    fill_in "Busprice", with: @airplane.busprice
    fill_in "Busrow", with: @airplane.busrow
    fill_in "Busseat", with: @airplane.busseat
    fill_in "Ecoemer", with: @airplane.ecoemer
    fill_in "Ecoprice", with: @airplane.ecoprice
    fill_in "Ecorow", with: @airplane.ecorow
    fill_in "Ecoseat", with: @airplane.ecoseat
    fill_in "Firstemer", with: @airplane.firstemer
    fill_in "Firstprice", with: @airplane.firstprice
    fill_in "Firstrow", with: @airplane.firstrow
    fill_in "Firstseat", with: @airplane.firstseat
    fill_in "Name", with: @airplane.name
    fill_in "Type", with: @airplane.type
    click_on "Create Airplane"

    assert_text "Airplane was successfully created"
    click_on "Back"
  end

  test "updating a Airplane" do
    visit airplanes_url
    click_on "Edit", match: :first

    fill_in "Busemer", with: @airplane.busemer
    fill_in "Busprice", with: @airplane.busprice
    fill_in "Busrow", with: @airplane.busrow
    fill_in "Busseat", with: @airplane.busseat
    fill_in "Ecoemer", with: @airplane.ecoemer
    fill_in "Ecoprice", with: @airplane.ecoprice
    fill_in "Ecorow", with: @airplane.ecorow
    fill_in "Ecoseat", with: @airplane.ecoseat
    fill_in "Firstemer", with: @airplane.firstemer
    fill_in "Firstprice", with: @airplane.firstprice
    fill_in "Firstrow", with: @airplane.firstrow
    fill_in "Firstseat", with: @airplane.firstseat
    fill_in "Name", with: @airplane.name
    fill_in "Type", with: @airplane.type
    click_on "Update Airplane"

    assert_text "Airplane was successfully updated"
    click_on "Back"
  end

  test "destroying a Airplane" do
    visit airplanes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Airplane was successfully destroyed"
  end
end
