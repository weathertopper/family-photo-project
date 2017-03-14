require 'test_helper'

class RelativesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @relative = relatives(:one)
  end

  test "should get index" do
    get relatives_url
    assert_response :success
  end

  test "should get new" do
    get new_relative_url
    assert_response :success
  end

  test "should create relative" do
    assert_difference('Relative.count') do
      post relatives_url, params: { relative: {  } }
    end

    assert_redirected_to relative_url(Relative.last)
  end

  test "should show relative" do
    get relative_url(@relative)
    assert_response :success
  end

  test "should get edit" do
    get edit_relative_url(@relative)
    assert_response :success
  end

  test "should update relative" do
    patch relative_url(@relative), params: { relative: {  } }
    assert_redirected_to relative_url(@relative)
  end

  test "should destroy relative" do
    assert_difference('Relative.count', -1) do
      delete relative_url(@relative)
    end

    assert_redirected_to relatives_url
  end
end
