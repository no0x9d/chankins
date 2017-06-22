defmodule Chankins.Web.ReleaseControllerTest do
  use Chankins.Web.ConnCase

  alias Chankins.ChangeManagement

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:release) do
    {:ok, release} = ChangeManagement.create_release(@create_attrs)
    release
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, release_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Releases"
  end

  test "renders form for new releases", %{conn: conn} do
    conn = get conn, release_path(conn, :new)
    assert html_response(conn, 200) =~ "New Release"
  end

  test "creates release and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, release_path(conn, :create), release: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == release_path(conn, :show, id)

    conn = get conn, release_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Release"
  end

  test "does not create release and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, release_path(conn, :create), release: @invalid_attrs
    assert html_response(conn, 200) =~ "New Release"
  end

  test "renders form for editing chosen release", %{conn: conn} do
    release = fixture(:release)
    conn = get conn, release_path(conn, :edit, release)
    assert html_response(conn, 200) =~ "Edit Release"
  end

  test "updates chosen release and redirects when data is valid", %{conn: conn} do
    release = fixture(:release)
    conn = put conn, release_path(conn, :update, release), release: @update_attrs
    assert redirected_to(conn) == release_path(conn, :show, release)

    conn = get conn, release_path(conn, :show, release)
    assert html_response(conn, 200) =~ "some updated version"
  end

  test "does not update chosen release and renders errors when data is invalid", %{conn: conn} do
    release = fixture(:release)
    conn = put conn, release_path(conn, :update, release), release: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Release"
  end

  test "deletes chosen release", %{conn: conn} do
    release = fixture(:release)
    conn = delete conn, release_path(conn, :delete, release)
    assert redirected_to(conn) == release_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, release_path(conn, :show, release)
    end
  end
end
