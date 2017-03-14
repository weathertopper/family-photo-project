require 'test_helper'

class MarriageBranchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @marriage_branch = marriage_branches(:one)
  end

  test "should get index" do
    get marriage_branches_url
    assert_response :success
  end

  test "should get new" do
    get new_marriage_branch_url
    assert_response :success
  end

  test "should create marriage_branch" do
    assert_difference('MarriageBranch.count') do
      post marriage_branches_url, params: { marriage_branch: {  } }
    end

    assert_redirected_to marriage_branch_url(MarriageBranch.last)
  end

  test "should show marriage_branch" do
    get marriage_branch_url(@marriage_branch)
    assert_response :success
  end

  test "should get edit" do
    get edit_marriage_branch_url(@marriage_branch)
    assert_response :success
  end

  test "should update marriage_branch" do
    patch marriage_branch_url(@marriage_branch), params: { marriage_branch: {  } }
    assert_redirected_to marriage_branch_url(@marriage_branch)
  end

  test "should destroy marriage_branch" do
    assert_difference('MarriageBranch.count', -1) do
      delete marriage_branch_url(@marriage_branch)
    end

    assert_redirected_to marriage_branches_url
  end
end
