defmodule Admin.Repo.Migrations.CreateWaypoint do
  use Ecto.Migration

  def change do
    create table(:waypoints) do
      add :title, :string
      add :curator, :string
      add :summary, :string
      add :description, :string

      timestamps
    end

  end
end
