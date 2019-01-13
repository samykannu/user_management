require 'test_helper'

class UserDynamicColumnsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_dynamic_column = user_dynamic_columns(:one)
  end

  test "should get index" do
    get user_dynamic_columns_url
    assert_response :success
  end

  test "should get new" do
    get new_user_dynamic_column_url
    assert_response :success
  end

  test "should create user_dynamic_column" do
    assert_difference('UserDynamicColumn.count') do
      post user_dynamic_columns_url, params: { user_dynamic_column: { meta_key: @user_dynamic_column.meta_key, meta_value: @user_dynamic_column.meta_value, user_id: @user_dynamic_column.user_id } }
    end

    assert_redirected_to user_dynamic_column_url(UserDynamicColumn.last)
  end

  test "should show user_dynamic_column" do
    get user_dynamic_column_url(@user_dynamic_column)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_dynamic_column_url(@user_dynamic_column)
    assert_response :success
  end

  test "should update user_dynamic_column" do
    patch user_dynamic_column_url(@user_dynamic_column), params: { user_dynamic_column: { meta_key: @user_dynamic_column.meta_key, meta_value: @user_dynamic_column.meta_value, user_id: @user_dynamic_column.user_id } }
    assert_redirected_to user_dynamic_column_url(@user_dynamic_column)
  end

  test "should destroy user_dynamic_column" do
    assert_difference('UserDynamicColumn.count', -1) do
      delete user_dynamic_column_url(@user_dynamic_column)
    end

    assert_redirected_to user_dynamic_columns_url
  end
end
