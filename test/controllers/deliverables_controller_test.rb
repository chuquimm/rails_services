require "test_helper"

class DeliverablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deliverable = deliverables(:one)
  end

  test "should get index" do
    get deliverables_url
    assert_response :success
  end

  test "should get new" do
    get new_deliverable_url
    assert_response :success
  end

  test "should create deliverable" do
    assert_difference("Deliverable.count") do
      post deliverables_url, params: { deliverable: { deadline: @deliverable.deadline, name: @deliverable.name, project_id: @deliverable.project_id } }
    end

    assert_redirected_to deliverable_url(Deliverable.last)
  end

  test "should show deliverable" do
    get deliverable_url(@deliverable)
    assert_response :success
  end

  test "should get edit" do
    get edit_deliverable_url(@deliverable)
    assert_response :success
  end

  test "should update deliverable" do
    patch deliverable_url(@deliverable), params: { deliverable: { deadline: @deliverable.deadline, name: @deliverable.name, project_id: @deliverable.project_id } }
    assert_redirected_to deliverable_url(@deliverable)
  end

  test "should destroy deliverable" do
    assert_difference("Deliverable.count", -1) do
      delete deliverable_url(@deliverable)
    end

    assert_redirected_to deliverables_url
  end
end
