defmodule Admin.WaypointController do
  use Admin.Web, :controller

  alias Admin.Waypoint

  plug :scrub_params, "waypoint" when action in [:create, :update]

  def index(conn, _params) do
    query = from w in Waypoint,
            preload: [:checkpoints]
    waypoints = Repo.all(query)
    render(conn, "index.html", waypoints: waypoints)
  end

  def new(conn, _params) do
    changeset = Waypoint.changeset(%Waypoint{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"waypoint" => waypoint_params}) do
    changeset = Waypoint.changeset(%Waypoint{}, waypoint_params)

    case Repo.insert(changeset) do
      {:ok, _waypoint} ->
        conn
        |> put_flash(:info, "Waypoint created successfully.")
        |> redirect(to: waypoint_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    waypoint = Repo.get!(Waypoint, id)
    render(conn, "show.html", waypoint: waypoint)
  end

  def edit(conn, %{"id" => id}) do
    waypoint = Repo.get!(Waypoint, id)
    changeset = Waypoint.changeset(waypoint)
    render(conn, "edit.html", waypoint: waypoint, changeset: changeset)
  end

  def update(conn, %{"id" => id, "waypoint" => waypoint_params}) do
    waypoint = Repo.get!(Waypoint, id)
    changeset = Waypoint.changeset(waypoint, waypoint_params)

    case Repo.update(changeset) do
      {:ok, waypoint} ->
        conn
        |> put_flash(:info, "Waypoint updated successfully.")
        |> redirect(to: waypoint_path(conn, :show, waypoint))
      {:error, changeset} ->
        render(conn, "edit.html", waypoint: waypoint, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    waypoint = Repo.get!(Waypoint, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(waypoint)

    conn
    |> put_flash(:info, "Waypoint deleted successfully.")
    |> redirect(to: waypoint_path(conn, :index))
  end
end
