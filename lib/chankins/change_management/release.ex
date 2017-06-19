    defmodule Chankins.ChangeManagement.Release do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chankins.ChangeManagement.Release


  schema "change_management_releases" do
    field :version, :string
    belongs_to :project, Chankins.ChangeManagement.Project
    has_many :versions, Chankins.ChangeManagement.Version

    timestamps()
  end

  @doc false
  def changeset(%Release{} = release, attrs) do
    release
    |> cast(attrs, [:version])
    |> validate_required([:version])
  end
end
