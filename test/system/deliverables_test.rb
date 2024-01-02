require "application_system_test_case"

class DeliverablesTest < ApplicationSystemTestCase
  setup do
    @deliverable = deliverables(:one)
  end

  test "visiting the index" do
    visit deliverables_url
    assert_selector "h1", text: "Deliverables"
  end

  test "should create deliverable" do
    visit deliverables_url
    click_on "New deliverable"

    fill_in "Deadline", with: @deliverable.deadline
    fill_in "Name", with: @deliverable.name
    fill_in "Project", with: @deliverable.project_id
    click_on "Create Deliverable"

    assert_text "Deliverable was successfully created"
    click_on "Back"
  end

  test "should update Deliverable" do
    visit deliverable_url(@deliverable)
    click_on "Edit this deliverable", match: :first

    fill_in "Deadline", with: @deliverable.deadline
    fill_in "Name", with: @deliverable.name
    fill_in "Project", with: @deliverable.project_id
    click_on "Update Deliverable"

    assert_text "Deliverable was successfully updated"
    click_on "Back"
  end

  test "should destroy Deliverable" do
    visit deliverable_url(@deliverable)
    click_on "Destroy this deliverable", match: :first

    assert_text "Deliverable was successfully destroyed"
  end
end
