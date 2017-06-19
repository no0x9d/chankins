defmodule Chankins.ChangeManagement.Version do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chankins.ChangeManagement.Version


  schema "change_management_versions" do
    field :release_date, :utc_datetime
    field :version, :string
    belongs_to :release, Chankins.ChangeManagement.Release

    timestamps()
  end

  @doc false
  def changeset(%Version{} = version, attrs) do
    version
    |> cast(attrs, [:version, :release_date])
    |> validate_required([:version, :release_date])
  end
end
