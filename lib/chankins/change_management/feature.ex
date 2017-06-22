defmodule Chankins.ChangeManagement.Feature do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chankins.ChangeManagement.{Feature, Version, Parameter}


  schema "change_management_features" do
    field :description, :string
    field :title, :string
    belongs_to :version, Version
    has_many :parameters, Parameter

    timestamps()
  end

  @doc false
  def changeset(%Feature{} = feature, attrs) do
    feature
    |> cast(attrs, [:title, :description, :version_id])
    |> validate_required([:title, :description])
  end
end
