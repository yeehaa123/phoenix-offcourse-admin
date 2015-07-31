defmodule Admin.WaypointTest do
  use Admin.ModelCase

  alias Admin.Waypoint

  @valid_attrs %{curator: "some content", description: "some content", summary: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Waypoint.changeset(%Waypoint{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Waypoint.changeset(%Waypoint{}, @invalid_attrs)
    refute changeset.valid?
  end
end
