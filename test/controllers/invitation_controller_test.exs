defmodule Library.InvitationControllerTest do
  use Library.ConnCase

  alias Library.Invitation
  @valid_attrs %{email: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, invitation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    invitation = Repo.insert! %Invitation{}
    conn = get conn, invitation_path(conn, :show, invitation)
    assert json_response(conn, 200)["data"] == %{
      "id" => "#{invitation.id}",
      "type" => "invitation",
      "attributes" => %{
        "email" => invitation.email
      }
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, invitation_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, invitation_path(conn, :create), data: %{attributes: @valid_attrs}
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Invitation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, invitation_path(conn, :create), data: %{attributes: @invalid_attrs}
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    invitation = Repo.insert! %Invitation{}
    conn = put conn, invitation_path(conn, :update, invitation), data: %{attributes: @valid_attrs}
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Invitation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    invitation = Repo.insert! %Invitation{}
    conn = put conn, invitation_path(conn, :update, invitation), data: %{attributes: @invalid_attrs}
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    invitation = Repo.insert! %Invitation{}
    conn = delete conn, invitation_path(conn, :delete, invitation)
    assert response(conn, 204)
    refute Repo.get(Invitation, invitation.id)
  end
end
