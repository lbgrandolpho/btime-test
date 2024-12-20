defmodule Backend.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string, null: false
      add :execution_date, :date, null: false
      add :location, :string, null: false
      add :priority, :string, null: false
      add :description, :string

      timestamps()
    end

    create unique_index(:tasks, [:name])
  end
end
