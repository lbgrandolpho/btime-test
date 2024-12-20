defmodule Backend.Model.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(name execution_date location priority description)a

  schema "tasks" do
    field(:description, :string)
    field(:execution_date, :date)
    field(:location, :string)
    field(:name, :string)
    field(:priority, :string)

    has_many(:attachments, Backend.Model.Attachment)

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_length(:name, min: 3)
    |> validate_inclusion(:priority, ["High", "Critical", "Low"])
    |> unique_constraint(:name)
  end
end
