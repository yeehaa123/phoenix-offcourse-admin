defmodule Admin.CheckpointTest do
  use Admin.ModelCase

  alias Admin.Checkpoint

  @valid_attrs %{description: "some content", instructions: [], title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Checkpoint.changeset(%Checkpoint{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Checkpoint.changeset(%Checkpoint{}, @invalid_attrs)
    refute changeset.valid?
  end
end
