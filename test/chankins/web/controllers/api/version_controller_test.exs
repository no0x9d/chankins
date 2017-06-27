defmodule Chankins.Web.API.VersionControllerTest do
  use Chankins.Web.ConnCase

  alias Chankins.ChangeManagement
  alias Chankins.ChangeManagement.Version

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:version) do
    {:ok, version} = ChangeManagement.create_version(@create_attrs)
    version
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_version_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates version and renders version when data is valid", %{conn: conn} do
    conn = post conn, api_version_path(conn, :create), version: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, api_version_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not create version and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_version_path(conn, :create), version: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen version and renders version when data is valid", %{conn: conn} do
    %Version{id: id} = version = fixture(:version)
    conn = put conn, api_version_path(conn, :update, version), version: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, api_version_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not update chosen version and renders errors when data is invalid", %{conn: conn} do
    version = fixture(:version)
    conn = put conn, api_version_path(conn, :update, version), version: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen version", %{conn: conn} do
    version = fixture(:version)
    conn = delete conn, api_version_path(conn, :delete, version)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, api_version_path(conn, :show, version)
    end
  end
end
