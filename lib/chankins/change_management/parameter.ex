defmodule Chankins.ChangeManagement.Parameter do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chankins.ChangeManagement.Parameter


  schema "change_management_parameters" do
    field :key, :string
    field :value, :string
    field :group, :string
    field :version_id, :id
    field :feature_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Parameter{} = parameter, attrs) do
    parameter
    |> cast(attrs, [:key, :value, :group, :version_id, :feature_id])
    |> validate_required([:key, :value, :group])
  end
end
