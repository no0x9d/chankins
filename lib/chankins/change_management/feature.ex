defmodule Chankins.ChangeManagement.Feature do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chankins.ChangeManagement.Feature


  schema "change_management_features" do
    field :description, :string
    field :title, :string
    belongs_to :version, Chankins.ChangeManagement.Version

    timestamps()
  end

  @doc false
  def changeset(%Feature{} = feature, attrs) do
    feature
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
