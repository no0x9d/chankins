defmodule Chankins.Web.ParameterController do
  use Chankins.Web, :controller

  alias Chankins.ChangeManagement

  def index(conn, _params) do
    parameters = ChangeManagement.list_parameters()
    render(conn, "index.html", parameters: parameters)
  end

  def new(conn, %{"feature" => feature_id}) do
    changeset = ChangeManagement.change_parameter(%Chankins.ChangeManagement.Parameter{feature_id: feature_id})
    render(conn, "new.html", [changeset: changeset] ++ versions_and_features())
  end
  def new(conn, %{"version" => version_id}) do
    changeset = ChangeManagement.change_parameter(%Chankins.ChangeManagement.Parameter{version_id: version_id})
    render(conn, "new.html", [changeset: changeset] ++ versions_and_features())
  end
  def new(conn, _params) do
    changeset = ChangeManagement.change_parameter(%Chankins.ChangeManagement.Parameter{})
    render(conn, "new.html", [changeset: changeset] ++ versions_and_features())
  end

  def create(conn, %{"parameter" => parameter_params}) do
    case ChangeManagement.create_parameter(parameter_params) do
      {:ok, parameter} ->
        conn
        |> put_flash(:info, "Parameter created successfully.")
        |> redirect(to: parameter_path(conn, :show, parameter))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", [changeset: changeset] ++ versions_and_features())
    end
  end

  def show(conn, %{"id" => id}) do
    parameter = ChangeManagement.get_parameter!(id)
    render(conn, "show.html", parameter: parameter)
  end

  def edit(conn, %{"id" => id}) do
    parameter = ChangeManagement.get_parameter!(id)
    changeset = ChangeManagement.change_parameter(parameter)
    render(conn, "edit.html", [parameter: parameter, changeset: changeset] ++ versions_and_features())
  end

  def update(conn, %{"id" => id, "parameter" => parameter_params}) do
    parameter = ChangeManagement.get_parameter!(id)

    case ChangeManagement.update_parameter(parameter, parameter_params) do
      {:ok, parameter} ->
        conn
        |> put_flash(:info, "Parameter updated successfully.")
        |> redirect(to: parameter_path(conn, :show, parameter))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", [parameter: parameter, changeset: changeset] ++ versions_and_features())
    end
  end

  def delete(conn, %{"id" => id}) do
    parameter = ChangeManagement.get_parameter!(id)
    {:ok, _parameter} = ChangeManagement.delete_parameter(parameter)

    conn
    |> put_flash(:info, "Parameter deleted successfully.")
    |> redirect(to: parameter_path(conn, :index))
  end

  defp versions_and_features do
    versions = ChangeManagement.list_versions()
    features = ChangeManagement.list_features()
    [versions: versions, features: features]
  end
end
