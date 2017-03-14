require 'test_helper'

class DescendantBranchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @descendant_branch = descendant_branches(:one)
  end

  test "should get index" do
    get descendant_branches_url
    assert_response :success
  end

  test "should get new" do
    get new_descendant_branch_url
    assert_response :success
  end

  test "should create descendant_branch" do
    assert_difference('DescendantBranch.count') do
      post descendant_branches_url, params: { descendant_branch: {  } }
    end

    assert_redirected_to descendant_branch_url(DescendantBranch.last)
  end

  test "should show descendant_branch" do
    get descendant_branch_url(@descendant_branch)
    assert_response :success
  end

  test "should get edit" do
    get edit_descendant_branch_url(@descendant_branch)
    assert_response :success
  end

  test "should update descendant_branch" do
    patch descendant_branch_url(@descendant_branch), params: { descendant_branch: {  } }
    assert_redirected_to descendant_branch_url(@descendant_branch)
  end

  test "should destroy descendant_branch" do
    assert_difference('DescendantBranch.count', -1) do
      delete descendant_branch_url(@descendant_branch)
    end

    assert_redirected_to descendant_branches_url
  end
end
