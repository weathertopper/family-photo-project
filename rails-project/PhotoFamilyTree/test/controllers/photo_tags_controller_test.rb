require 'test_helper'

class PhotoTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @photo_tag = photo_tags(:one)
  end

  test "should get index" do
    get photo_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_photo_tag_url
    assert_response :success
  end

  test "should create photo_tag" do
    assert_difference('PhotoTag.count') do
      post photo_tags_url, params: { photo_tag: {  } }
    end

    assert_redirected_to photo_tag_url(PhotoTag.last)
  end

  test "should show photo_tag" do
    get photo_tag_url(@photo_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_photo_tag_url(@photo_tag)
    assert_response :success
  end

  test "should update photo_tag" do
    patch photo_tag_url(@photo_tag), params: { photo_tag: {  } }
    assert_redirected_to photo_tag_url(@photo_tag)
  end

  test "should destroy photo_tag" do
    assert_difference('PhotoTag.count', -1) do
      delete photo_tag_url(@photo_tag)
    end

    assert_redirected_to photo_tags_url
  end
end
