require "application_system_test_case"

class UserDynamicColumnsTest < ApplicationSystemTestCase
  setup do
    @user_dynamic_column = user_dynamic_columns(:one)
  end

  test "visiting the index" do
    visit user_dynamic_columns_url
    assert_selector "h1", text: "User Dynamic Columns"
  end

  test "creating a User dynamic column" do
    visit user_dynamic_columns_url
    click_on "New User Dynamic Column"

    fill_in "Meta key", with: @user_dynamic_column.meta_key
    fill_in "Meta value", with: @user_dynamic_column.meta_value
    fill_in "User", with: @user_dynamic_column.user_id
    click_on "Create User dynamic column"

    assert_text "User dynamic column was successfully created"
    click_on "Back"
  end

  test "updating a User dynamic column" do
    visit user_dynamic_columns_url
    click_on "Edit", match: :first

    fill_in "Meta key", with: @user_dynamic_column.meta_key
    fill_in "Meta value", with: @user_dynamic_column.meta_value
    fill_in "User", with: @user_dynamic_column.user_id
    click_on "Update User dynamic column"

    assert_text "User dynamic column was successfully updated"
    click_on "Back"
  end

  test "destroying a User dynamic column" do
    visit user_dynamic_columns_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User dynamic column was successfully destroyed"
  end
end
