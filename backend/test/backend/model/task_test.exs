defmodule Backend.Model.TaskTest do
  use Backend.DataCase, async: true

  alias Backend.Model.Task

  @valid_attrs %{
    name: "Task 1",
    description: "Description",
    execution_date: ~D[2023-10-01],
    location: "Location",
    priority: "High"
  }
  @invalid_attrs %{name: nil, description: nil, execution_date: nil, location: nil, priority: nil}

  test "changeset with valid attributes" do
    changeset = Task.changeset(%Task{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Task.changeset(%Task{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with short name" do
    changeset = Task.changeset(%Task{}, Map.put(@valid_attrs, :name, "Ta"))
    refute changeset.valid?
  end

  test "changeset with invalid priority" do
    changeset = Task.changeset(%Task{}, Map.put(@valid_attrs, :priority, "Invalid"))
    refute changeset.valid?
  end
end
