defmodule Backend.Model.AttachmentTest do
  use Backend.DataCase, async: true

  alias Backend.Model.{Attachment, Task}

  setup do
    task = %Task{
      name: "Task 1",
      description: "Description",
      execution_date: ~D[2023-10-01],
      location: "Location",
      priority: "High"
    }

    {:ok, task: Repo.insert!(task)}
  end

  @valid_attrs %{url: "http://example.com/file1"}
  @invalid_attrs %{url: nil}

  test "changeset with valid attributes", %{task: task} do
    changeset = Attachment.changeset(%Attachment{}, Map.put(@valid_attrs, :task_id, task.id))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Attachment.changeset(%Attachment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
