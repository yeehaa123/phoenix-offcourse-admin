defmodule Admin.Checkpoint do
  use Admin.Web, :model

  schema "checkpoints" do
    belongs_to :waypoint, Admin.Waypoint
    field :title, :string
    field :description, :string
    field :instructions, {:array, :string}

    timestamps
  end

  @required_fields ~w(title description instructions)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
