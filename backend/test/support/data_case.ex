defmodule Backend.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Backend.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Backend.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Backend.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Backend.Repo, {:shared, self()})
    end

    :ok
  end
end
