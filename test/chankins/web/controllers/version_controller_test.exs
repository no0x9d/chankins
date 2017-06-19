defmodule Chankins.Web.VersionControllerTest do
  use Chankins.Web.ConnCase

  alias Chankins.ChangeManagement

  @create_attrs %{release_date: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}, version: "some version"}
  @update_attrs %{release_date: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}, version: "some updated version"}
  @invalid_attrs %{release_date: nil, version: nil}

  def fixture(:version) do
    {:ok, version} = ChangeManagement.create_version(@create_attrs)
    version
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, version_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Versions"
  end

  test "renders form for new versions", %{conn: conn} do
    conn = get conn, version_path(conn, :new)
    assert html_response(conn, 200) =~ "New Version"
  end

  test "creates version and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, version_path(conn, :create), version: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == version_path(conn, :show, id)

    conn = get conn, version_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Version"
  end

  test "does not create version and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, version_path(conn, :create), version: @invalid_attrs
    assert html_response(conn, 200) =~ "New Version"
  end

  test "renders form for editing chosen version", %{conn: conn} do
    version = fixture(:version)
    conn = get conn, version_path(conn, :edit, version)
    assert html_response(conn, 200) =~ "Edit Version"
  end

  test "updates chosen version and redirects when data is valid", %{conn: conn} do
    version = fixture(:version)
    conn = put conn, version_path(conn, :update, version), version: @update_attrs
    assert redirected_to(conn) == version_path(conn, :show, version)

    conn = get conn, version_path(conn, :show, version)
    assert html_response(conn, 200) =~ "some updated version"
  end

  test "does not update chosen version and renders errors when data is invalid", %{conn: conn} do
    version = fixture(:version)
    conn = put conn, version_path(conn, :update, version), version: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Version"
  end

  test "deletes chosen version", %{conn: conn} do
    version = fixture(:version)
    conn = delete conn, version_path(conn, :delete, version)
    assert redirected_to(conn) == version_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, version_path(conn, :show, version)
    end
  end
end
