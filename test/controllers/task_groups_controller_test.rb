require "test_helper"

class TaskGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_group = task_groups(:one)
  end

  test "should get index" do
    get task_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_task_group_url
    assert_response :success
  end

  test "should create task_group" do
    assert_difference("TaskGroup.count") do
      post task_groups_url, params: { task_group: { description: @task_group.description, name: @task_group.name, user_id: @task_group.user_id } }
    end

    assert_redirected_to task_group_url(TaskGroup.last)
  end

  test "should show task_group" do
    get task_group_url(@task_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_group_url(@task_group)
    assert_response :success
  end

  test "should update task_group" do
    patch task_group_url(@task_group), params: { task_group: { description: @task_group.description, name: @task_group.name, user_id: @task_group.user_id } }
    assert_redirected_to task_group_url(@task_group)
  end

  test "should destroy task_group" do
    assert_difference("TaskGroup.count", -1) do
      delete task_group_url(@task_group)
    end

    assert_redirected_to task_groups_url
  end
end
