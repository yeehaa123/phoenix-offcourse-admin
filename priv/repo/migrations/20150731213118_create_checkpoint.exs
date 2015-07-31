defmodule Admin.Repo.Migrations.CreateCheckpoint do
  use Ecto.Migration

  def change do
    create table(:checkpoints) do
      add :waypoint_id, references(:waypoints)
      add :title, :string
      add :description, :string
      add :instructions, {:array, :string}

      timestamps
    end

  end
end
