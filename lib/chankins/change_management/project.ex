defmodule Chankins.ChangeManagement.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chankins.ChangeManagement.Project


  schema "change_management_projects" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
