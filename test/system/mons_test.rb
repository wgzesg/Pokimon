require "application_system_test_case"

class MonsTest < ApplicationSystemTestCase
  setup do
    @mon = mons(:one)
  end

  test "visiting the index" do
    visit mons_url
    assert_selector "h1", text: "Mons"
  end

  test "creating a Mon" do
    visit mons_url
    click_on "New Mon"

    fill_in "Abilities", with: @mon.abilities
    fill_in "Name", with: @mon.name
    click_on "Create Mon"

    assert_text "Mon was successfully created"
    click_on "Back"
  end

  test "updating a Mon" do
    visit mons_url
    click_on "Edit", match: :first

    fill_in "Abilities", with: @mon.abilities
    fill_in "Name", with: @mon.name
    click_on "Update Mon"

    assert_text "Mon was successfully updated"
    click_on "Back"
  end

  test "destroying a Mon" do
    visit mons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mon was successfully destroyed"
  end
end
