defmodule Chankins.Web.API.ProjectControllerTest do
  use Chankins.Web.ConnCase

  alias Chankins.ChangeManagement
  alias Chankins.ChangeManagement.Project

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:project) do
    {:ok, project} = ChangeManagement.create_project(@create_attrs)
    project
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_project_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates project and renders project when data is valid", %{conn: conn} do
    conn = post conn, api_project_path(conn, :create), project: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, api_project_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not create project and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_project_path(conn, :create), project: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen project and renders project when data is valid", %{conn: conn} do
    %Project{id: id} = project = fixture(:project)
    conn = put conn, api_project_path(conn, :update, project), project: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, api_project_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not update chosen project and renders errors when data is invalid", %{conn: conn} do
    project = fixture(:project)
    conn = put conn, api_project_path(conn, :update, project), project: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen project", %{conn: conn} do
    project = fixture(:project)
    conn = delete conn, api_project_path(conn, :delete, project)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, api_project_path(conn, :show, project)
    end
  end
end
