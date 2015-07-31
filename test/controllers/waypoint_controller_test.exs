defmodule Admin.WaypointControllerTest do
  use Admin.ConnCase

  alias Admin.Waypoint
  @valid_attrs %{curator: "some content", description: "some content", summary: "some content", title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, waypoint_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing waypoints"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, waypoint_path(conn, :new)
    assert html_response(conn, 200) =~ "New waypoint"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, waypoint_path(conn, :create), waypoint: @valid_attrs
    assert redirected_to(conn) == waypoint_path(conn, :index)
    assert Repo.get_by(Waypoint, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, waypoint_path(conn, :create), waypoint: @invalid_attrs
    assert html_response(conn, 200) =~ "New waypoint"
  end

  test "shows chosen resource", %{conn: conn} do
    waypoint = Repo.insert! %Waypoint{}
    conn = get conn, waypoint_path(conn, :show, waypoint)
    assert html_response(conn, 200) =~ "Show waypoint"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, waypoint_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    waypoint = Repo.insert! %Waypoint{}
    conn = get conn, waypoint_path(conn, :edit, waypoint)
    assert html_response(conn, 200) =~ "Edit waypoint"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    waypoint = Repo.insert! %Waypoint{}
    conn = put conn, waypoint_path(conn, :update, waypoint), waypoint: @valid_attrs
    assert redirected_to(conn) == waypoint_path(conn, :show, waypoint)
    assert Repo.get_by(Waypoint, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    waypoint = Repo.insert! %Waypoint{}
    conn = put conn, waypoint_path(conn, :update, waypoint), waypoint: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit waypoint"
  end

  test "deletes chosen resource", %{conn: conn} do
    waypoint = Repo.insert! %Waypoint{}
    conn = delete conn, waypoint_path(conn, :delete, waypoint)
    assert redirected_to(conn) == waypoint_path(conn, :index)
    refute Repo.get(Waypoint, waypoint.id)
  end
end
