defmodule Admin.CheckpointController do
  use Admin.Web, :controller
  alias Admin.Checkpoint
  alias Admin.Waypoint
  plug :find_waypoint
  plug :action

  defp find_waypoint(conn, _params) do
    waypoint = Repo.get(Waypoint, conn.params["waypoint_id"])
    assign(conn, :waypoint, waypoint)
  end

  def index(conn, _params) do
    waypoint = conn.assigns.waypoint
    checkpoints = Repo.all assoc(waypoint, :checkpoints)
    render conn, checkpoints: checkpoints, waypoint: waypoint
  end

  def new(conn, _) do
    changeset = Checkpoint.changeset(%Checkpoint{})
    render conn, changeset: changeset
  end

  def create(conn, %{"checkpoint" => checkpoint_params}) do
    changeset = build(conn.assigns.waypoint, :checkpoints)
      |> Checkpoint.changeset(checkpoint_params)

    if changeset.valid? do
      Repo.insert(changeset)
      conn
        |> put_flash(:info, "Checkpoint has been successfully created.")
        |> redirect(to: waypoint_checkpoint_path(conn, :index, conn.assigns.waypoint))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end
end
