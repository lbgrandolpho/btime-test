defmodule Backend.Service.TaskService do
  alias Backend.Model.Task
  alias Backend.Repo

  import Ecto.Query

  def list_tasks(_parent, args, _resolution) do
    query =
      Task
      |> apply_filters(args)
      |> apply_pagination(args)
      |> preload(:attachments)

    tasks = Repo.all(query)
    {:ok, tasks}
  end

  def get_task(_parent, %{id: id}, _resolution) do
    task = Repo.get(Task, id) |> Repo.preload(:attachments)

    case task do
      nil -> {:error, "Task not found"}
      task -> {:ok, task}
    end
  end

  defp apply_filters(query, args) do
    query
    |> filter_by_name(args[:name])
    |> filter_by_description(args[:description])
    |> filter_by_execution_date(args[:execution_date])
    |> filter_by_priority(args[:priority])
    |> filter_by_location(args[:location])
  end

  defp filter_by_name(query, nil), do: query

  defp filter_by_name(query, name) do
    from(t in query, where: ilike(t.name, ^"%#{name}%"))
  end

  defp filter_by_description(query, nil), do: query

  defp filter_by_description(query, description) do
    from(t in query, where: ilike(t.description, ^"%#{description}%"))
  end

  defp filter_by_execution_date(query, nil), do: query

  defp filter_by_execution_date(query, execution_date) do
    from(t in query, where: t.execution_date == ^execution_date)
  end

  defp filter_by_priority(query, nil), do: query

  defp filter_by_priority(query, priority) do
    from(t in query, where: t.priority == ^priority)
  end

  defp filter_by_location(query, nil), do: query

  defp filter_by_location(query, location) do
    from(t in query, where: ilike(t.location, ^"%#{location}%"))
  end

  defp apply_pagination(query, %{limit: limit, offset: offset}) do
    query
    |> limit(^limit)
    |> offset(^offset)
  end

  defp apply_pagination(query, %{limit: limit}) do
    query
    |> limit(^limit)
  end

  defp apply_pagination(query, %{offset: offset}) do
    query
    |> offset(^offset)
  end

  defp apply_pagination(query, _args), do: query
end
