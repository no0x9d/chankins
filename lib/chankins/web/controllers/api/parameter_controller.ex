defmodule Chankins.Web.API.ParameterController do
  use Chankins.Web, :controller

  alias Chankins.ChangeManagement
  alias Chankins.ChangeManagement.Parameter

  action_fallback Chankins.Web.FallbackController

  def index(conn, _params) do
    parameters = ChangeManagement.list_parameters()
    render(conn, "index.json", parameters: parameters)
  end

  def create(conn, %{"parameter" => parameter_params}) do
    with {:ok, %Parameter{} = parameter} <- ChangeManagement.create_parameter(parameter_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_parameter_path(conn, :show, parameter))
      |> render("show.json", parameter: parameter)
    end
  end

  def show(conn, %{"id" => id}) do
    parameter = ChangeManagement.get_parameter!(id)
    render(conn, "show.json", parameter: parameter)
  end

  def update(conn, %{"id" => id, "parameter" => parameter_params}) do
    parameter = ChangeManagement.get_parameter!(id)

    with {:ok, %Parameter{} = parameter} <- ChangeManagement.update_parameter(parameter, parameter_params) do
      render(conn, "show.json", parameter: parameter)
    end
  end

  def delete(conn, %{"id" => id}) do
    parameter = ChangeManagement.get_parameter!(id)
    with {:ok, %Parameter{}} <- ChangeManagement.delete_parameter(parameter) do
      send_resp(conn, :no_content, "")
    end
  end
end
