require "test_helper"

class ApiUsagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_usage = api_usages(:one)
  end

  test "should get index" do
    get api_usages_url
    assert_response :success
  end

  test "should get new" do
    get new_api_usage_url
    assert_response :success
  end

  test "should create api_usage" do
    assert_difference("ApiUsage.count") do
      post api_usages_url, params: { api_usage: { cache_hit: @api_usage.cache_hit, endpoint: @api_usage.endpoint, location_id: @api_usage.location_id, user_id: @api_usage.user_id } }
    end

    assert_redirected_to api_usage_url(ApiUsage.last)
  end

  test "should show api_usage" do
    get api_usage_url(@api_usage)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_usage_url(@api_usage)
    assert_response :success
  end

  test "should update api_usage" do
    patch api_usage_url(@api_usage), params: { api_usage: { cache_hit: @api_usage.cache_hit, endpoint: @api_usage.endpoint, location_id: @api_usage.location_id, user_id: @api_usage.user_id } }
    assert_redirected_to api_usage_url(@api_usage)
  end

  test "should destroy api_usage" do
    assert_difference("ApiUsage.count", -1) do
      delete api_usage_url(@api_usage)
    end

    assert_redirected_to api_usages_url
  end
end
