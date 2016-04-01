defmodule Library.LibraryControllerTest do
  use Library.ConnCase

  alias Library.Library
  @valid_attrs %{address: "some content", name: "some content", phone: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, library_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    library = Repo.insert! %Library{}
    conn = get conn, library_path(conn, :show, library)
    assert json_response(conn, 200)["data"] == %{
      "id" => "#{library.id}",
      "type" => "library",
      "attributes" => %{
        "name" => library.name,
        "address" => library.address,
        "phone" => library.phone
      }
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, library_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, library_path(conn, :create), data: %{ attributes: @valid_attrs }
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Library, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, library_path(conn, :create), data: %{ attributes: @invalid_attrs }
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    library = Repo.insert! %Library{}
    conn = put conn, library_path(conn, :update, library), data: %{ attributes: @valid_attrs }
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Library, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    library = Repo.insert! %Library{}
    conn = put conn, library_path(conn, :update, library), data: %{ attributes: @invalid_attrs }
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    library = Repo.insert! %Library{}
    conn = delete conn, library_path(conn, :delete, library)
    assert response(conn, 204)
    refute Repo.get(Library, library.id)
  end
end
