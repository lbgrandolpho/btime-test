defmodule BackendWeb.Schema do
  use Absinthe.Schema

  alias Backend.Service.TaskService

  import_types(Absinthe.Type.Custom)
  import_types(BackendWeb.Schema.Types)

  query do
    field :tasks, list_of(:task) do
      arg(:name, :string)
      arg(:description, :string)
      arg(:execution_date, :date)
      arg(:priority, :string)
      arg(:location, :string)
      arg(:limit, :integer)
      arg(:offset, :integer)

      resolve(&TaskService.list_tasks/3)
    end

    field :task, :task do
      arg(:id, non_null(:id))

      resolve(&TaskService.get_task/3)
    end
  end
end
