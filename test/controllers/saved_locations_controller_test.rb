require "test_helper"

class SavedLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @saved_location = saved_locations(:one)
  end

  test "should get index" do
    get saved_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_saved_location_url
    assert_response :success
  end

  test "should create saved_location" do
    assert_difference("SavedLocation.count") do
      post saved_locations_url, params: { saved_location: { is_current_location: @saved_location.is_current_location, location_id: @saved_location.location_id, user_id: @saved_location.user_id } }
    end

    assert_redirected_to saved_location_url(SavedLocation.last)
  end

  test "should show saved_location" do
    get saved_location_url(@saved_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_saved_location_url(@saved_location)
    assert_response :success
  end

  test "should update saved_location" do
    patch saved_location_url(@saved_location), params: { saved_location: { is_current_location: @saved_location.is_current_location, location_id: @saved_location.location_id, user_id: @saved_location.user_id } }
    assert_redirected_to saved_location_url(@saved_location)
  end

  test "should destroy saved_location" do
    assert_difference("SavedLocation.count", -1) do
      delete saved_location_url(@saved_location)
    end

    assert_redirected_to saved_locations_url
  end
end
