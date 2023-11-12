require "application_system_test_case"

class TaskGroupsTest < ApplicationSystemTestCase
  setup do
    @task_group = task_groups(:one)
  end

  test "visiting the index" do
    visit task_groups_url
    assert_selector "h1", text: "Task groups"
  end

  test "should create task group" do
    visit task_groups_url
    click_on "New task group"

    fill_in "Description", with: @task_group.description
    fill_in "Name", with: @task_group.name
    fill_in "User", with: @task_group.user_id
    click_on "Create Task group"

    assert_text "Task group was successfully created"
    click_on "Back"
  end

  test "should update Task group" do
    visit task_group_url(@task_group)
    click_on "Edit this task group", match: :first

    fill_in "Description", with: @task_group.description
    fill_in "Name", with: @task_group.name
    fill_in "User", with: @task_group.user_id
    click_on "Update Task group"

    assert_text "Task group was successfully updated"
    click_on "Back"
  end

  test "should destroy Task group" do
    visit task_group_url(@task_group)
    click_on "Destroy this task group", match: :first

    assert_text "Task group was successfully destroyed"
  end
end
