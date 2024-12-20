defmodule BackendWeb.SchemaTest do
  use Backend.DataCase, async: true

  alias Backend.Model.Task
  alias Backend.Model.Attachment
  alias Backend.Repo

  @list_query """
  {
    tasks {
      id
      name
      description
      execution_date
      location
      priority
      attachments {
        id
        url
      }
    }
  }
  """

  @get_query """
  query($id: ID!) {
    task(id: $id) {
      id
      name
      description
      execution_date
      location
      priority
      attachments {
        id
        url
      }
    }
  }
  """

  test "list tasks" do
    task =
      %Task{
        name: "Task 1",
        description: "Description of Task 1",
        execution_date: ~D[2023-10-01],
        location: "Location 1",
        priority: "High"
      }
      |> Repo.insert!()

    attachment =
      %Attachment{
        url: "http://example.com/file1",
        task_id: task.id
      }
      |> Repo.insert!()

    response = Absinthe.run(@list_query, BackendWeb.Schema)

    assert {:ok, %{data: %{"tasks" => tasks}}} = response
    assert length(tasks) == 1
    assert hd(tasks)["name"] == "Task 1"
    assert hd(tasks)["attachments"] |> length() == 1
    assert hd(tasks)["attachments"] |> hd() |> Map.get("url") == "http://example.com/file1"
  end

  test "get task details" do
    task =
      %Task{
        name: "Task 1",
        description: "Description of Task 1",
        execution_date: ~D[2023-10-01],
        location: "Location 1",
        priority: "High"
      }
      |> Repo.insert!()

    attachment =
      %Attachment{
        url: "http://example.com/file1",
        task_id: task.id
      }
      |> Repo.insert!()

    response = Absinthe.run(@get_query, BackendWeb.Schema, variables: %{"id" => task.id})

    assert {:ok, %{data: %{"task" => task_data}}} = response
    assert task_data["name"] == "Task 1"
    assert task_data["attachments"] |> length() == 1
    assert task_data["attachments"] |> hd() |> Map.get("url") == "http://example.com/file1"
  end
end
