defmodule Chankins.Web.API.ReleaseControllerTest do
  use Chankins.Web.ConnCase

  alias Chankins.ChangeManagement
  alias Chankins.ChangeManagement.Release

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:release) do
    {:ok, release} = ChangeManagement.create_release(@create_attrs)
    release
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_release_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates release and renders release when data is valid", %{conn: conn} do
    conn = post conn, api_release_path(conn, :create), release: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, api_release_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not create release and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_release_path(conn, :create), release: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen release and renders release when data is valid", %{conn: conn} do
    %Release{id: id} = release = fixture(:release)
    conn = put conn, api_release_path(conn, :update, release), release: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, api_release_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id}
  end

  test "does not update chosen release and renders errors when data is invalid", %{conn: conn} do
    release = fixture(:release)
    conn = put conn, api_release_path(conn, :update, release), release: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen release", %{conn: conn} do
    release = fixture(:release)
    conn = delete conn, api_release_path(conn, :delete, release)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, api_release_path(conn, :show, release)
    end
  end
end
