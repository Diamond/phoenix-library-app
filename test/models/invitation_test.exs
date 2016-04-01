defmodule Library.InvitationTest do
  use Library.ModelCase

  alias Library.Invitation

  @valid_attrs %{email: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Invitation.changeset(%Invitation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Invitation.changeset(%Invitation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
