defmodule Backend.Model.Attachment do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w(url task_id)a

  schema "attachments" do
    field(:url, :string)
    belongs_to(:task, Backend.Model.Task)

    timestamps()
  end

  def changeset(attachment, attrs) do
    attachment
    |> cast(attrs, @fields)
    |> validate_required([:task_id])
    |> foreign_key_constraint(:task_id)
  end
end
