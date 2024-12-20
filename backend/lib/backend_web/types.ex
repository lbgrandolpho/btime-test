defmodule BackendWeb.Schema.Types do
  use Absinthe.Schema.Notation

  object :task do
    field(:id, :id)
    field(:description, :string)
    field(:execution_date, :date)
    field(:location, :string)
    field(:name, :string)
    field(:priority, :string)
    field(:attachments, list_of(:attachment))
    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)
  end

  object :attachment do
    field(:id, :id)
    field(:url, :string)
    field(:task_id, :id)
    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)
  end
end
